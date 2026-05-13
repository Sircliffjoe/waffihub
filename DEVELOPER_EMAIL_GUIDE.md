# Email System - Developer Integration Guide

## Overview
This guide explains how the email system works and how to integrate new events that should trigger emails.

## System Architecture

```
Event Triggered
    ↓
Controller Action
    ↓
Model Created/Updated
    ↓
Mailer.method.deliver_later
    ↓
Email queued in Solid Queue
    ↓
Job processed
    ↓
SMTP delivery to Brevo
    ↓
Email logged to database
```

## Email Model

### Location
`app/models/email.rb`

### Fields
```ruby
Email.new(
  recipient_email: "user@example.com",  # Required, validated
  recipient_name: "John Doe",           # Optional
  subject: "Your notification",         # Required
  body: "Email content",                # Required
  contact_type: "manual",               # Enum: application, enrollment, booking, manual
  status: "sent",                       # Enum: sent, pending, failed
  user_id: nil,                         # Optional, foreign key to User
  created_at: Time.current              # Auto timestamp
)
```

### Enums
```ruby
contact_type: { application: "application", enrollment: "enrollment", booking: "booking", manual: "manual" }
status: { sent: "sent", pending: "pending", failed: "failed" }
```

## Creating New Email Notifications

### Step 1: Create a Mailer

Create a new file in `app/mailers/my_event_mailer.rb`:

```ruby
class MyEventMailer < ApplicationMailer
  def notify_admin(my_object)
    @object = my_object
    subject = "New Event: #{@object.title}"
    body = "Event details go here"
    
    mail(to: admin_email_address, subject: subject, body: body)
    record_email(admin_email_address, "Admin", subject, body, "my_event_type")
  end

  def notify_user(my_object)
    @object = my_object
    subject = "Event Confirmation"
    body = "Thank you for your action"
    
    mail(to: @object.email, subject: subject, body: body)
    record_email(@object.email, @object.name, subject, body, "my_event_type")
  end

  def notify_admin_and_user(my_object)
    notify_admin(my_object)
    notify_user(my_object)
  end

  private

  def admin_email_address
    ENV['ADMIN_EMAIL'] || 'admin@waffihub.ng'
  end
end
```

### Step 2: Trigger Mailer from Controller

In your controller action:

```ruby
class MyController < ApplicationController
  def create
    @object = MyModel.create(my_params)
    
    if @object.save
      # Send email notifications
      MyEventMailer.notify_admin_and_user(@object).deliver_later
      
      redirect_to path, notice: "Success!"
    else
      render :new
    end
  end
end
```

### Step 3: (Optional) Add Contact Type Enum

If this is a new event type, update the Email model:

```ruby
# app/models/email.rb
enum :contact_type, { 
  application: "application", 
  enrollment: "enrollment", 
  booking: "booking", 
  my_event_type: "my_event_type",  # Add this
  manual: "manual" 
}
```

## Helper Methods

### record_email (in ApplicationMailer)
Logs email to database for audit trail:

```ruby
record_email(
  email_address,           # Recipient email
  name,                   # Recipient name
  subject,                # Email subject
  body,                   # Email body
  contact_type            # Type enum value
)
```

## Best Practices

### ✅ Do's
- Use `deliver_later` for async delivery (non-blocking)
- Always include both admin and user notification
- Log all emails to database (use `record_email`)
- Use descriptive subject lines
- Include contact type for categorization
- Handle nil gracefully (optional: names)
- Use plain text for now (HTML coming later)

### ❌ Don'ts
- Don't call `deliver_now` on production
- Don't hardcode admin email (use ENV variable)
- Don't send duplicate emails
- Don't include secrets in email body
- Don't forget to call `record_email`
- Don't use HTML (not yet supported)

## Email Body Best Practices

### Template
```
Dear [Name],

[Main message]

[Call to action if applicable]

Regards,
WaffiHub Team
```

### Example
```ruby
body = "Dear #{@user.name},\n\n" +
       "Thank you for enrolling in #{@program.title}.\n" +
       "Your enrollment is confirmed.\n\n" +
       "You can access your dashboard at: [URL]\n\n" +
       "Regards,\nWaffiHub Team"
```

## Testing in Development

### Send Test Email
```ruby
# In Rails console
user = User.find(1)
MyEventMailer.notify_user(user).deliver_now
```

### Check Email Logs
```bash
tail -f log/development.log | grep "Mail"
```

### View Sent Emails
1. Go to Admin Panel → Email Messages
2. See all sent emails with status

## Error Handling

### If Email Fails to Send
- Status is set to "failed"
- Error logged to `log/development.log`
- Email record created anyway (for audit)
- User doesn't see error (job silently fails)

### Debugging Failed Emails
```ruby
# Check failed emails
Email.failed.recent

# Look at development log
grep "ERROR" log/development.log
```

## Configuration Reference

### SMTP Settings
```ruby
# In config/environments/development.rb or production.rb
config.action_mailer.smtp_settings = {
  address: 'smtp-relay.brevo.com',
  port: 587,
  user_name: ENV.fetch('BREVO_API_KEY'),
  password: ENV.fetch('BREVO_API_KEY'),
  authentication: 'login',
  enable_starttls_auto: true
}
```

### Environment Variables
```env
BREVO_API_KEY=xkeysib-...  # Required
ADMIN_EMAIL=admin@waffihub.ng  # Optional, defaults to this
```

## Mailer Method Patterns

### Pattern 1: Single Recipient
```ruby
def notify_someone(object)
  mail(to: object.email, subject: "Subject", body: "Body")
  record_email(object.email, object.name, "Subject", "Body", "type")
end
```

### Pattern 2: Multiple Recipients in Separate Emails
```ruby
def notify_admin_and_user(object)
  notify_admin(object)
  notify_user(object)
end

def notify_admin(object)
  mail(to: admin_email, subject: "...", body: "...")
  record_email(admin_email, "Admin", "...", "...", "type")
end

def notify_user(object)
  mail(to: object.email, subject: "...", body: "...")
  record_email(object.email, object.name, "...", "...", "type")
end
```

## Events Currently Implemented

### 1. Project Application
- **Mailer**: `ProjectApplicationMailer`
- **Trigger**: `ProjectsController#submit_application`
- **Notifications**: Admin + Applicant
- **Type**: "application"

### 2. Program Enrollment
- **Mailer**: `EnrollmentMailer`
- **Trigger**: `PaymentsController#callback` (enrollment creation)
- **Notifications**: Admin + Enrollee
- **Type**: "enrollment"

### 3. Service Booking
- **Mailer**: `BookingMailer`
- **Trigger**: `PaymentsController#callback` (booking creation)
- **Notifications**: Admin + Booker
- **Type**: "booking"

## Custom Email Sending

For emails sent from admin panel:

```ruby
# Admin creates and sends email via UI
Email.create(
  recipient_email: "user@example.com",
  recipient_name: "User Name",
  subject: "Custom Message",
  body: "Message content",
  contact_type: "manual",
  status: "sent"
)

# Email is sent immediately
```

## Monitoring & Analytics

### View Email Statistics
```ruby
# Total emails sent
Email.count

# By type
Email.application.count
Email.enrollment.count
Email.booking.count
Email.manual.count

# By status
Email.sent.count
Email.failed.count

# Recent emails
Email.order(created_at: :desc).limit(10)
```

## Future Enhancements

1. **HTML Templates**: Support for HTML email body
2. **Variables**: Support {{variable}} substitution
3. **Attachments**: Add file attachments to emails
4. **Scheduling**: Schedule emails for later sending
5. **A/B Testing**: Test different subject lines
6. **Tracking**: Open rate and click tracking
7. **Unsubscribe**: Manage email preferences
8. **Bounce Handling**: Auto-process bounces
9. **Campaigns**: Group related emails as campaigns
10. **Webhooks**: Receive delivery status updates from Brevo

## Troubleshooting Guide

### Issue: Email not sending
**Solution**: 
1. Check BREVO_API_KEY in .env
2. Verify email address format
3. Check `log/development.log` for errors
4. Try sending test email in console

### Issue: Jobs not processing
**Solution**:
1. Check Solid Queue is running: `bin/rails solid_queue:start`
2. Check queue status: `ActiveJob::Status.job_status(job_id)`
3. Review queue logs

### Issue: Recipient not found
**Solution**:
1. Manually enter email address
2. Check email format is correct
3. Email may not be in any user table yet

### Issue: Email marked as failed
**Solution**:
1. Review the specific email in admin panel
2. Check SMTP settings
3. Verify Brevo account status
4. Retry with different recipient

---

**Last Updated**: May 13, 2026
**Version**: 1.0

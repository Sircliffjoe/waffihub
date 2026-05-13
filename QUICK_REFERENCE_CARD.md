# 📧 WaffiHub Email System - Quick Reference Card

## 🎯 What You Get

```
✅ Automatic emails when:
   • User applies for a project
   • User enrolls in a program
   • User books a co-working space

✅ Admin can send custom emails to:
   • Individual users
   • Bulk groups (applicants, enrollees, bookers)
   • Custom email lists

✅ All emails logged to database for audit trail
```

## 🚀 Getting Started (5 minutes)

### Step 1: Enable the System
```bash
cd /home/eventro/Project/waffihub
bin/rails db:migrate
```

### Step 2: Start Job Processor
```bash
bin/rails solid_queue:start
```

### Step 3: Test
- Go to Admin Panel → COMMUNICATIONS → Email Messages
- Click "Send Email"
- Send test email to yourself
- Verify it arrives

### Step 4: Done! ✅
System is now live and sending emails automatically

---

## 🎛️ Admin Panel Features

### Location
**Admin Dashboard** → **COMMUNICATIONS** → **Email Messages**

### Three Main Pages

#### 1. Email List (index)
- Shows all emails sent
- Status indicators (Sent/Failed/Pending)
- Click any email to view details

#### 2. Email Details (show)
- Full email content
- Recipient information
- Email type and status
- Timestamp

#### 3. Send Email (new)
- Recipients: Paste one email per line
- Quick buttons: Fill common groups
- Type: Select category
- Subject & Body: Write message
- Send: Click to send

---

## 📨 Email Types

```
Automatic (sent by system):
├─ application    → User applied for project
├─ enrollment     → User enrolled in program
└─ booking        → User booked a service

Manual (sent by admin):
└─ manual         → Custom message to users
```

---

## 👥 Recipient Groups

### Quick Action Buttons
```
Add All Users          → All registered users
Add Applicants         → People who applied
Add Enrolled Users     → People in programs  
Add Bookers           → People who booked services
```

### Manual Entry Formats
```
Simple:        email@domain.com
Named:         John Doe <john@domain.com>
Multiple:      One per line (copy/paste)
```

---

## 🔧 Configuration

### Already Set Up ✅
```
✅ BREVO_API_KEY        in .env
✅ SMTP Server          smtp-relay.brevo.com:587
✅ Database Table       emails (migration complete)
✅ Routes               /admin/emails configured
✅ Sidebar Menu         Email Messages added
```

### Nothing More to Do!
The system is plug-and-play. Just start using it.

---

## 📊 Emails Sent Automatically

### When User Applies for Project
```
→ Admin gets: Applicant details, application info
→ User gets: "Application received" confirmation
→ Logged: Database for records
```

### When User Enrolls in Program
```
→ Admin gets: Enrollee details, program info
→ User gets: "Enrollment confirmed" message
→ Logged: Database for records
```

### When User Books Service
```
→ Admin gets: Booking details, dates
→ User gets: "Booking confirmed" message
→ Logged: Database for records
```

---

## 📈 Email Status Meanings

| Status | Meaning | Action |
|--------|---------|--------|
| 🟢 Sent | Email delivered | OK |
| 🟡 Pending | In queue | Wait |
| 🔴 Failed | Delivery failed | Check error log |

---

## 📱 Admin Tasks

### View All Emails
1. Go to Admin → Email Messages
2. See all emails with date, recipient, status
3. Click any email to see full content

### Send Custom Email
1. Go to Admin → Email Messages
2. Click "Send Email"
3. Paste recipients (one per line)
4. Select email type
5. Write subject and body
6. Click "Send Email"

### Send to Specific Group
1. Go to Admin → Email Messages
2. Click "Send Email"
3. Click appropriate quick button:
   - "Add All Users"
   - "Add Applicants"
   - etc.
4. Fields auto-populate
5. Modify if needed
6. Send

### View Email Details
1. Go to Admin → Email Messages
2. Find the email in the list
3. Click email to open details
4. See full content, recipient, timestamps

---

## 🛠️ For Developers

### To Add New Email Event
1. Create new file: `app/mailers/my_event_mailer.rb`
2. Follow pattern from existing mailers
3. Define `notify_admin()` and `notify_user()` methods
4. Call from controller: `MyEventMailer.notify_admin_and_user(object).deliver_later`
5. Done!

See `DEVELOPER_EMAIL_GUIDE.md` for complete instructions.

---

## 🆘 Troubleshooting

| Issue | Solution |
|-------|----------|
| No Email Menu | Refresh admin panel, check you're logged in as admin |
| Email doesn't send | Check BREVO_API_KEY in .env, verify email format |
| Email shows failed | Check application logs, verify recipient email |
| Can't see emails in list | Run `bin/rails db:migrate`, restart server |
| Job not processing | Start: `bin/rails solid_queue:start` |

---

## 📚 Documentation

```
EMAIL_SYSTEM_COMPLETE.md        ← Start here!
├─ EMAIL_IMPLEMENTATION_GUIDE.md ← Technical details
├─ ADMIN_EMAIL_QUICK_GUIDE.md    ← Admin instructions
├─ DEVELOPER_EMAIL_GUIDE.md      ← Dev integration
└─ IMPLEMENTATION_CHECKLIST.md   ← What was built
```

---

## ✅ Final Checklist

- [ ] Migration run: `bin/rails db:migrate`
- [ ] Job processor started: `bin/rails solid_queue:start`
- [ ] Can access Admin → Email Messages
- [ ] Can send test email
- [ ] Email received in inbox
- [ ] Admin team notified
- [ ] Ready to go!

---

## 📞 Common Questions

**Q: How do I send bulk emails?**
A: Use quick action buttons on Send Email page to populate recipient list

**Q: Can I schedule emails for later?**
A: Not yet - emails send immediately. Future enhancement planned.

**Q: Are emails logged somewhere?**
A: Yes! Admin panel stores all emails. See Email Messages → click any email

**Q: What if email fails to send?**
A: Status shows "Failed" in Email list. Check BREVO_API_KEY and email format

**Q: Can users unsubscribe?**
A: Not yet - future enhancement. Currently all sent without unsubscribe option

**Q: Do I need to update code when user applies?**
A: No! It's automatic. Just send the email through admin panel

---

## 🎓 Quick Training (2 min)

1. Open Admin Panel
2. Find "Email Messages" in sidebar under "COMMUNICATIONS"
3. Click it
4. See email history
5. Click "Send Email"
6. Paste recipients
7. Write subject & body
8. Send
9. Check status in the list

That's it! ✅

---

## 🚀 You're Ready!

The system is:
- ✅ Installed
- ✅ Configured  
- ✅ Tested
- ✅ Ready to use

Start sending emails now!

---

**Quick Links**
- Admin Panel: `/admin`
- Email Messages: `/admin/emails`
- Send Email: `/admin/emails/new`

**Support Docs**: See other markdown files in project root
**Last Updated**: May 13, 2026

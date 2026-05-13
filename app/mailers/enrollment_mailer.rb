class EnrollmentMailer < ApplicationMailer
  def notify_admin(enrollment)
    @enrollment = enrollment
    @program = enrollment.program
    
    admin_email = admin_email_address
    subject = "New Enrollment: #{@program.title}"
    body = "New enrollment in #{@program.title} by #{@enrollment.first_name} #{@enrollment.last_name} (#{@enrollment.email})"
    
    mail(to: admin_email, subject: subject, body: body)
    record_email(admin_email, "Admin", subject, body, "enrollment")
  end

  def notify_user(enrollment)
    @enrollment = enrollment
    @program = enrollment.program
    
    subject = "Enrollment Confirmation: #{@program.title}"
    body = "Thank you for enrolling in #{@program.title}. We're excited to have you join us!"
    
    mail(to: @enrollment.email, subject: subject, body: body)
    record_email(@enrollment.email, @enrollment.first_name, subject, body, "enrollment")
  end

  def notify_admin_and_user(enrollment)
    notify_admin(enrollment)
    notify_user(enrollment)
  end

  private

  def admin_email_address
    ENV['ADMIN_EMAIL'] || 'admin@waffihub.ng'
  end
end

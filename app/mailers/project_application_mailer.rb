class ProjectApplicationMailer < ApplicationMailer
  def notify_admin(project_application)
    @application = project_application
    @project = project_application.project
    
    admin_email = admin_email_address
    subject = "New Project Application: #{@project.title} - #{@application.first_name} #{@application.last_name}"
    body = "New application received from #{@application.first_name} #{@application.last_name} (#{@application.email}) for #{@project.title}"
    
    mail(to: admin_email, subject: subject, body: body)
    record_email(admin_email, "Admin", subject, body, "application")
  end

  def notify_user(project_application)
    @application = project_application
    @project = project_application.project
    
    subject = "Application Received: #{@project.title}"
    body = "Thank you for applying to #{@project.title}. We have received your application and will review it shortly."
    
    mail(to: @application.email, subject: subject, body: body)
    record_email(@application.email, @application.first_name, subject, body, "application")
  end

  def notify_admin_and_user(project_application)
    notify_admin(project_application)
    notify_user(project_application)
  end

  private

  def admin_email_address
    ENV['ADMIN_EMAIL'] || 'admin@waffihub.ng'
  end
end

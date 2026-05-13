class BookingMailer < ApplicationMailer
  def notify_admin(booking)
    @booking = booking
    @plan = booking.plan
    
    admin_email = admin_email_address
    subject = "New Booking: #{@plan.name} - #{@booking.first_name} #{@booking.last_name}"
    body = "New booking for #{@plan.name} by #{@booking.first_name} #{@booking.last_name} (#{@booking.email}) from #{@booking.start_date} to #{@booking.end_date}"
    
    mail(to: admin_email, subject: subject, body: body)
    record_email(admin_email, "Admin", subject, body, "booking")
  end

  def notify_user(booking)
    @booking = booking
    @plan = booking.plan
    
    subject = "Booking Confirmation: #{@plan.name}"
    body = "Thank you for booking #{@plan.name}. Your booking is confirmed from #{@booking.start_date} to #{@booking.end_date}."
    
    mail(to: @booking.email, subject: subject, body: body)
    record_email(@booking.email, @booking.first_name, subject, body, "booking")
  end

  def notify_admin_and_user(booking)
    notify_admin(booking)
    notify_user(booking)
  end

  private

  def admin_email_address
    ENV['ADMIN_EMAIL'] || 'admin@waffihub.ng'
  end
end

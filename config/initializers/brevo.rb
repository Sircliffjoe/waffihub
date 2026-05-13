# config/initializers/brevo.rb
require 'brevo'

Brevo.configure do |config|
  config.api_key['api-key'] = ENV['BREVO_API_KEY']
end

class BrevoDelivery
  def initialize(settings)
    @settings = settings
  end

  def deliver!(mail)
    api_instance = Brevo::TransactionalEmailsApi.new
    
    # Prepare the email data
    send_smtp_email = Brevo::SendSmtpEmail.new(
      sender: { email: mail.from.first, name: "WaffiHub" },
      to: mail.to.map { |email| { email: email } },
      subject: mail.subject
    )

    # Set HTML and/or Text content
    if mail.html_part
      send_smtp_email.html_content = mail.html_part.body.decoded
      send_smtp_email.text_content = mail.text_part.body.decoded if mail.text_part
    else
      send_smtp_email.text_content = mail.body.decoded
    end

    # Handle attachments if any
    if mail.attachments.any?
      send_smtp_email.attachment = mail.attachments.map do |attachment|
        {
          content: Base64.strict_encode64(attachment.body.decoded),
          name: attachment.filename
        }
      end
    end

    begin
      api_instance.send_transac_email(send_smtp_email)
    rescue Brevo::ApiError => e
      Rails.logger.error "Brevo API Error: #{e.code} - #{e.response_body}"
      raise e
    end
  end
end

ActionMailer::Base.add_delivery_method :brevo, BrevoDelivery

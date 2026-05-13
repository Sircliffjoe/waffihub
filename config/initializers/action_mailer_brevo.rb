# config/initializers/action_mailer_brevo.rb
Rails.application.config.to_prepare do
  lib_file = Rails.root.join('lib', 'brevo_delivery.rb')

  if File.exist?(lib_file)
    require lib_file

    if defined?(BrevoDelivery)
      ActionMailer::Base.add_delivery_method :brevo_delivery, BrevoDelivery
      ActionMailer::Base.delivery_method = :brevo_delivery
      Rails.logger.info "[ActionMailer] :brevo_delivery is now ACTIVE"
    end
  end
end
class Email < ApplicationRecord
  belongs_to :user, optional: true

  validates :recipient_email, :subject, :body, presence: true
  validates :recipient_email, format: { with: URI::MailTo::EMAIL_REGEXP }

  enum :contact_type, { application: "application", enrollment: "enrollment", booking: "booking", manual: "manual" }
  enum :status, { sent: "sent", pending: "pending", failed: "failed" }
end

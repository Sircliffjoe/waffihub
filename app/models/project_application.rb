class ProjectApplication < ApplicationRecord
  belongs_to :project

  enum :marital_status, { single: "Single", married: "Married" }

  validates :first_name, :last_name, :email, :phone, :address, :background, :reason, presence: true
  validates :age_group, :marital_status, :course_track, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, format: { with: /\A[\d\s\-\+\(\)]+\z/, message: "is not a valid phone number" }
end

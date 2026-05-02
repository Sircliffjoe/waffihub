class Partner < ApplicationRecord
  has_one_attached :logo
  validates :name, presence: true
end

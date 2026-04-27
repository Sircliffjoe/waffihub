class Service < ApplicationRecord
  has_rich_text :description
  has_one_attached :image

  validates :title, presence: true
end

class Program < ApplicationRecord
  has_rich_text :description
  has_one_attached :main_image

  validates :title, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end

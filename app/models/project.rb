class Project < ApplicationRecord
  has_rich_text :problem
  has_rich_text :solution
  has_rich_text :outcome
  has_one_attached :main_image
  has_many_attached :images

  validates :name, presence: true
  validates :client, presence: true
end

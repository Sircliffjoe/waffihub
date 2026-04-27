class Partnership < ApplicationRecord
  has_rich_text :description
  has_one_attached :logo

  validates :name, presence: true
end

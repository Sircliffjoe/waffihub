class Plan < ApplicationRecord
  validates :name, :price, :interval, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end

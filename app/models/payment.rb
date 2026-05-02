class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :program, optional: true
  belongs_to :plan, optional: true

  validates :amount, presence: true
  validates :status, presence: true
  validates :transaction_reference, presence: true, uniqueness: true
end

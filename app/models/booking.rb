class Booking < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :plan

  validates :status, presence: true
  validates :start_date, presence: true

  before_validation :set_dates, on: :create

  private

  def set_dates
    self.start_date ||= Date.today
    case plan.interval.downcase
    when '/day'
      self.end_date = start_date + 1.day
    when '/week'
      self.end_date = start_date + 1.week
    when '/mo'
      self.end_date = start_date + 1.month
    else
      self.end_date = start_date + 1.month
    end
  end
end

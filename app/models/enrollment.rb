class Enrollment < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :program
end

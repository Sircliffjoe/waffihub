class TeamMember < ApplicationRecord
  has_rich_text :bio
  has_one_attached :image

  validates :name, presence: true
  validates :role, presence: true
end

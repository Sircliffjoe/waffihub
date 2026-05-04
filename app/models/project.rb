class Project < ApplicationRecord
  has_many :project_applications, dependent: :destroy
  has_many :project_partnerships, dependent: :destroy
  has_rich_text :problem
  has_rich_text :solution
  has_rich_text :outcome
  has_one_attached :main_image
  has_many_attached :images

  before_validation :generate_slug, if: :name_changed?

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true

  def to_param
    slug
  end

  private

  def generate_slug
    self.slug = name.parameterize if name.present?
  end
end

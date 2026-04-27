class Post < ApplicationRecord
  has_rich_text :content
  has_one_attached :featured_image

  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true

  before_validation :generate_slug

  private

  def generate_slug
    self.slug ||= title.parameterize if title
  end
end

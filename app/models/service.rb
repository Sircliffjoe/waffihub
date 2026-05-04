class Service < ApplicationRecord
  has_rich_text :description
  has_one_attached :image

  has_many_attached :images

  validates :title, presence: true
  validate :image_count_within_limit

  private

  def image_count_within_limit
    if images.attached? && images.count > 4
      errors.add(:images, "You can only upload a maximum of 4 images")
    end
  end
end

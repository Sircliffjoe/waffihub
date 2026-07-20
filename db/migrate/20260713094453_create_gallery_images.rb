class CreateGalleryImages < ActiveRecord::Migration[8.1]
  def change
    create_table :gallery_images do |t|
      t.string :title
      t.text :description
      t.string :category
      t.date :event_date

      t.timestamps
    end
  end
end

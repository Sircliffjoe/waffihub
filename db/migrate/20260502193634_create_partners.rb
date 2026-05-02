class CreatePartners < ActiveRecord::Migration[8.1]
  def change
    create_table :partners do |t|
      t.string :name
      t.string :website_url
      t.integer :position

      t.timestamps
    end
  end
end

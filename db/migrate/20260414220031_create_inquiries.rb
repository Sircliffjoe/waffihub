class CreateInquiries < ActiveRecord::Migration[8.1]
  def change
    create_table :inquiries do |t|
      t.string :name
      t.string :email
      t.string :subject

      t.timestamps
    end
  end
end

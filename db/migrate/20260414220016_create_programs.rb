class CreatePrograms < ActiveRecord::Migration[8.1]
  def change
    create_table :programs do |t|
      t.string :title
      t.decimal :price
      t.string :duration
      t.string :mode
      t.string :instructor

      t.timestamps
    end
  end
end

class CreateServices < ActiveRecord::Migration[8.1]
  def change
    create_table :services do |t|
      t.string :title
      t.decimal :pricing
      t.string :category

      t.timestamps
    end
  end
end

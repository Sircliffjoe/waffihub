class CreatePlans < ActiveRecord::Migration[8.1]
  def change
    create_table :plans do |t|
      t.string :name
      t.decimal :price
      t.string :interval
      t.jsonb :features
      t.boolean :highlight

      t.timestamps
    end
  end
end

class CreatePosts < ActiveRecord::Migration[8.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.datetime :published_at
      t.string :slug

      t.timestamps
    end
    add_index :posts, :slug
  end
end

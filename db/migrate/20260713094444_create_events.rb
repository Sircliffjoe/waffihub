class CreateEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :events do |t|
      t.string :title
      t.string :category
      t.datetime :start_time
      t.datetime :end_time
      t.string :location
      t.string :google_calendar_link
      t.string :border_color

      t.timestamps
    end
  end
end

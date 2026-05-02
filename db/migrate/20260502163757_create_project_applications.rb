class CreateProjectApplications < ActiveRecord::Migration[8.1]
  def change
    create_table :project_applications do |t|
      t.references :project, null: false, foreign_key: true
      t.string :name
      t.string :email
      t.string :phone
      t.string :location
      t.text :background
      t.text :reason
      t.string :status

      t.timestamps
    end
  end
end

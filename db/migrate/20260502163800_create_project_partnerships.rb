class CreateProjectPartnerships < ActiveRecord::Migration[8.1]
  def change
    create_table :project_partnerships do |t|
      t.references :project, null: false, foreign_key: true
      t.string :organization_name
      t.string :contact_person
      t.string :email
      t.string :phone
      t.string :partnership_type
      t.text :message
      t.string :status

      t.timestamps
    end
  end
end

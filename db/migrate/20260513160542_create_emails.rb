class CreateEmails < ActiveRecord::Migration[8.1]
  def change
    create_table :emails do |t|
      t.string :recipient_email, null: false
      t.string :recipient_name
      t.string :subject, null: false
      t.text :body, null: false
      t.string :contact_type
      t.string :status, default: "sent"
      t.bigint :user_id
      t.datetime :created_at, null: false

      t.index :recipient_email
      t.index :user_id
    end
  end
end

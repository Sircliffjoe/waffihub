class CreatePayments < ActiveRecord::Migration[8.1]
  def change
    create_table :payments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :program, null: false, foreign_key: true
      t.decimal :amount
      t.string :status
      t.string :transaction_reference
      t.string :paystack_reference

      t.timestamps
    end
  end
end

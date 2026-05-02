class UpdatePaymentsAndCreateBookings < ActiveRecord::Migration[8.1]
  def change
    # Update Payments
    add_reference :payments, :plan, foreign_key: true, null: true
    change_column_null :payments, :program_id, true

    # Create Bookings
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :plan, null: false, foreign_key: true
      t.string :status, default: "pending"
      t.date :start_date
      t.date :end_date
      t.timestamps
    end
  end
end

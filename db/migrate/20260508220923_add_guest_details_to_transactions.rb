class AddGuestDetailsToTransactions < ActiveRecord::Migration[8.1]
  def change
    # Add guest details to payments
    add_column :payments, :first_name, :string
    add_column :payments, :last_name, :string
    add_column :payments, :email, :string
    add_column :payments, :phone, :string
    add_column :payments, :address, :text

    # Add guest details to enrollments
    add_column :enrollments, :first_name, :string
    add_column :enrollments, :last_name, :string
    add_column :enrollments, :email, :string
    add_column :enrollments, :phone, :string
    add_column :enrollments, :address, :text

    # Add guest details to bookings
    add_column :bookings, :first_name, :string
    add_column :bookings, :last_name, :string
    add_column :bookings, :email, :string
    add_column :bookings, :phone, :string
    add_column :bookings, :address, :text

    # Add extra guest details to project_applications (it already has email and phone)
    add_column :project_applications, :first_name, :string
    add_column :project_applications, :last_name, :string
    add_column :project_applications, :address, :text

    # Also make user_id optional for these tables
    change_column_null :payments, :user_id, true
    change_column_null :enrollments, :user_id, true
    change_column_null :bookings, :user_id, true
  end
end

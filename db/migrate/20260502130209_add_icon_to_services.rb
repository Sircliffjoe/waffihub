class AddIconToServices < ActiveRecord::Migration[8.1]
  def change
    add_column :services, :icon, :string
  end
end

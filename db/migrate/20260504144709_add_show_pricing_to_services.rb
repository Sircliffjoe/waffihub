class AddShowPricingToServices < ActiveRecord::Migration[8.1]
  def change
    add_column :services, :show_pricing, :boolean
  end
end

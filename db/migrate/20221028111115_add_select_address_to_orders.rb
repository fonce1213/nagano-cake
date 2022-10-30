class AddSelectAddressToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :select_address, :integer
  end
end

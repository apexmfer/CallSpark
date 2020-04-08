class AddProductVendorToCall < ActiveRecord::Migration[5.2]
  def change
    add_column :calls, :product_vendor_id, :integer
  end
end

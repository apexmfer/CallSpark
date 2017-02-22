class ResizeVendorNoTwo < ActiveRecord::Migration
  def change
     change_column :bi_orders, :bi_vendor_no, :integer, limit: 8
  end
end

class ResizeMetricVendorNo < ActiveRecord::Migration
  def change
     change_column :sales_metrics, :bi_vendor_no, :integer, limit: 8
  end
end

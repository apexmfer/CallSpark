class ResizeVendorNo < ActiveRecord::Migration
  def change
     change_column :bi_vendors, :no, :integer, limit: 8
    

  end
end

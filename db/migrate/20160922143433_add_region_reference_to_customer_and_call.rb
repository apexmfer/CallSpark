class AddRegionReferenceToCustomerAndCall < ActiveRecord::Migration
  def change
   
    add_column :customers, :region_id, :integer
    add_index :customers, :region_id

    add_column :calls, :region_id, :integer
    add_index :calls, :region_id
  end
end

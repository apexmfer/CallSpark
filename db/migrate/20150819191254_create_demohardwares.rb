class CreateDemohardwares < ActiveRecord::Migration
  def change
    create_table :demohardwares do |t|

      t.integer :product_id
      t.integer :barcode
      t.string :series

      t.timestamps
    end
  end
end

class CreateBiVendors < ActiveRecord::Migration
  def change
    create_table :bi_vendors, id: false do |t|
      t.integer :no, primary_key:true
      t.integer :number, null:false

      t.timestamps null: false
    end
  end
end

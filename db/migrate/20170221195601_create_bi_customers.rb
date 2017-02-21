class CreateBiCustomers < ActiveRecord::Migration
  def change
    create_table :bi_customers, id: false do |t|
      t.integer :no, primary_key:true
      t.string :name, null:false
      t.string :customer_type
      t.integer :bi_outside_sales_rep_id
      t.integer :bi_inside_sales_rep_id

      t.timestamps null: false
    end
  end
end

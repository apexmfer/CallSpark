class CreateBiQuotes < ActiveRecord::Migration
  def change
    create_table :bi_quotes do |t|
      t.integer :order_number, null:false
      t.integer :order_suffix
      t.integer :line_number
      t.string :ship_prod
      t.string :prod_desc
      t.string :warehouse
      t.integer :bi_customer_no
      t.string :customer_po
      t.string :ship_to_name
      t.string :ship_to_address1
      t.string :ship_to_city
      t.string :ship_to_state
      t.integer :prod_cost_cents
      t.integer :price_cents
      t.integer :sales_cents
      t.integer :bi_inside_sales_rep_id
      t.integer :bi_outside_sales_rep_id
      t.string :prod_category
      t.integer :bi_vendor_no, limit: 8
      t.integer :qty_ord
      t.datetime :enter_date
      t.datetime :promise_date
      t.datetime :request_date

      t.timestamps null: false
    end
  end
end

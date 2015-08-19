class CreateCheckouts < ActiveRecord::Migration
  def change
    create_table :checkouts do |t|

      t.integer :checkout_user_id

     t.integer :hardware_id
     t.integer :customer_id

     t.datetime :time_out
     t.datetime :expected_time_in
     t.datetime :actual_time_in
      t.text :notes

      t.timestamps
    end
  end
end

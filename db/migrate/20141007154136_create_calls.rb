class CreateCalls < ActiveRecord::Migration
  def change
    create_table :calls do |t|
      
      t.integer :customer_id
      t.integer :category_id
      t.text :text

      t.timestamps
    end
  end
end

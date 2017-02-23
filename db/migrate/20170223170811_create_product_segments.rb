class CreateProductSegments < ActiveRecord::Migration
  def change
    create_table :product_segments do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end

class CreateProductSegmentFocus < ActiveRecord::Migration
  def change
    create_table :product_segment_focus do |t|
      t.integer :focused_no
      t.string :focused_type
      t.integer :product_segment_id

      t.timestamps null: false
    end
  end
end

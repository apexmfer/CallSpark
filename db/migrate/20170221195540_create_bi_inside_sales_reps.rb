class CreateBiInsideSalesReps < ActiveRecord::Migration
  def change
    create_table :bi_inside_sales_reps do |t|
      t.string :code, null:false
      t.string :name, null:false

      t.timestamps null: false
    end
  end
end

class CreateSalesMetrics < ActiveRecord::Migration
  def change
    create_table :sales_metrics do |t|
      t.integer :metric_type
      t.integer :value_cents
      t.integer :measured_id
      t.string :measured_type

      t.timestamps null: false
    end
  end
end

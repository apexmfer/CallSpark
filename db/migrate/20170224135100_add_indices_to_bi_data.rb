class AddIndicesToBiData < ActiveRecord::Migration
  def change

    add_index :bi_orders, :bi_customer_no, :name => 'bi_order_customer_no_ix'
    add_index :bi_orders, :bi_vendor_no, :name => 'bi_order_vendor_no_ix'
    add_index :bi_quotes, :bi_customer_no, :name => 'bi_quote_customer_no_ix'
    add_index :bi_quotes, :bi_vendor_no, :name => 'bi_quote_vendor_no_ix'

    add_index :sales_metrics, :bi_customer_no, :name => 'metric_customer_no_ix'
    add_index :sales_metrics, :bi_vendor_no, :name => 'metric_vendor_no_ix'


    add_index :bi_customers, :bi_outside_sales_rep_id, :name => 'bi_outside_sales_rep_id_ix'
    add_index :bi_customers, :bi_inside_sales_rep_id, :name => 'bi_inside_sales_rep_id_ix'

    add_index :companies, :bi_customer_no, :name => 'bi_customer_no_ix'


    #polymorphic index
    add_index :initiative_targets, [:bi_targetted_id,:bi_targetted_type], :name => 'bi_initiative_targets_ix'
    add_index :product_segment_focus, [:focused_id,:focused_type], :name => 'bi_product_segment_focus_ix'
    add_index :sales_metrics, [:measured_id, :measured_type], :name => 'bi_sales_metric_measured_ix'

    add_index :sales_metrics, :metric_type
  end
end

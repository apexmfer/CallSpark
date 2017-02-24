class SalesMetric < ActiveRecord::Base

  belongs_to :measured, polymorphic: true


  enum metric_type: {
    customer_sales: 0,
    customer_costs: 1,
    vendor_sales: 2,
    vendor_costs: 3
  }


end

class SalesMetric < ActiveRecord::Base

  belongs_to :measured, polymorphic: true

  belongs_to :bi_vendor
  belongs_to :bi_customer


  enum metric_type: {
    customer_sales: 0,
    customer_costs: 1,
    vendor_sales: 2,
    vendor_costs: 3
  }

  def company
    if bi_customer and bi_customer.company
      return bi_customer.company
    end
  end

  def company_name
    if company
      return company.name
    end
  end



end

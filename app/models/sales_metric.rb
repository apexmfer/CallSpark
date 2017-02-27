class SalesMetric < ActiveRecord::Base

  belongs_to :measured, polymorphic: true

  belongs_to :bi_vendor, foreign_key: 'bi_vendor_no', primary_key:'no'
  belongs_to :bi_customer, foreign_key: 'bi_customer_no', primary_key:'no'

 monetize :value_cents

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
 
   if bi_customer
      return bi_customer.name
    end
  end


  def vendor_name

   if vendor
      return vendor.name
    end
  end

  def value_formatted
    return value
  end


end

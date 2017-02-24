class BiVendor < ActiveRecord::Base
    validates :no, presence: true, uniqueness:true

    has_many :bi_quotes, foreign_key: :bi_vendor_no
    has_many :bi_orders, foreign_key: :bi_vendor_no

    has_many :initiative_targets, as: :targetted
    has_many :initiatives, through: :initiative_targets

    has_many :sales_metrics, foreign_key: :bi_vendor_no, primary_key: :no 


    def getTotalSalesMetricsPerCustomer
      return sales_metrics.where(metric_type: SalesMetric.metric_types[:customer_sales] )
    end

    def getTotalCostsMetricsPerCustomer
      return sales_metrics.where(metric_type: SalesMetric.metric_types[:customer_costs]  )
    end



    def getTotalSalesMetricsWithCustomer(cust)
      return sales_metrics.where(metric_type: SalesMetric.metric_types[:customer_sales], bi_customer_no: cust.no)
    end

    def getTotalCostsMetricsWithCustomer(cust)
      return sales_metrics.where(metric_type: SalesMetric.metric_types[:customer_costs], bi_customer_no: cust.no  )
    end


end

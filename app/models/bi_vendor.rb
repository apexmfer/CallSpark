class BiVendor < ActiveRecord::Base
    validates :no, presence: true, uniqueness:true

    has_many :bi_quotes, foreign_key: :bi_vendor_no
    has_many :bi_orders, foreign_key: :bi_vendor_no

    has_many :initiative_targets, as: :targetted
    has_many :initiatives, through: :initiative_targets

    has_many :sales_metrics, foreign_key: :bi_vendor_no


    def getTotalSalesMetricsPerCustomer
      return SalesMetric.where(metric_type: SalesMetric.metric_types[:vendor_sales], measured_type:'BiCustomer' )
    end

    def getTotalSalesMetricsPerCustomer
      return SalesMetric.where(metric_type: SalesMetric.metric_types[:vendor_costs], measured_type:'BiCustomer' )
    end


    def getTotalSalesMetricsWithCustomer(cust)
      return SalesMetric.where(metric_type: SalesMetric.metric_types[:vendor_sales],measured_id: cust.no, measured_type:'BiCustomer' ).last
    end

    def getTotalCostsMetricsWithCustomer(cust)
      return SalesMetric.where(metric_type: SalesMetric.metric_types[:vendor_costs],measured_id: cust.no, measured_type:'BiCustomer' ).last
    end


end

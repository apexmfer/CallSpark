class BiCustomer < ActiveRecord::Base
  validates :no, presence: true, uniqueness:true

  has_many :company#, foreign_key: "bi_customer_no"

  belongs_to :bi_outside_sales_rep
  belongs_to :bi_inside_sales_rep

  has_many :initiative_targets, as: :targetted
    has_many :initiatives, through: :initiative_targets

    has_many :bi_quotes
    has_many :bi_orders

      has_many :sales_metrics, foreign_key: :bi_customer_no

  def getOutsideSalesProfileName
    if bi_outside_sales_rep
      return bi_outside_sales_rep.getProfileName
    end
  end

  def getInsideSalesProfileName
      if bi_inside_sales_rep
        return bi_inside_sales_rep.getProfileName
      end
  end

  def getTotalSalesMetricsPerVendor
    return sales_metrics.where(metric_type: SalesMetric.metric_types[:vendor_sales] )
  end

  def getTotalCostsMetricsPerVendor
    return sales_metrics.where(metric_type: SalesMetric.metric_types[:vendor_costs]  )
  end



  def getTotalSalesMetricsWithVendor(vend)
    return sales_metrics.where(metric_type: SalesMetric.metric_types[:vendor_sales], bi_vendor_no: vend.no)
  end

  def getTotalCostsMetricsWithVendor(vend)
    return sales_metrics.where(metric_type: SalesMetric.metric_types[:vendor_costs], bi_vendor_no: vend.no  )
  end

  has_many :sales_metrics, as: :measured
end

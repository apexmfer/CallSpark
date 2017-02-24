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
    return SalesMetric.where(metric_type: SalesMetric.metric_types[:vendor_sales], measured_type:'BiCustomer' )
  end

  def getTotalSalesMetricsPerVendor
    return SalesMetric.where(metric_type: SalesMetric.metric_types[:vendor_costs], measured_type:'BiCustomer' )
  end



  def getTotalSalesMetricsWithVendor(vend)
    return SalesMetric.where(metric_type: SalesMetric.metric_types[:customer_sales],measured_id: vend.no, measured_type:'BiVendor' ).last
  end

  def getTotalCostsMetricsWithVendor(vend)
    return SalesMetric.where(metric_type: SalesMetric.metric_types[:customer_costs],measured_id: vend.no, measured_type:'BiVendor' ).last
  end

  has_many :sales_metrics, as: :measured
end

class BiCustomer < ActiveRecord::Base
  validates :no, presence: true, uniqueness:true


   has_many :sales_metrics, foreign_key: :bi_customer_no, primary_key: :no

   #  SalesMetric Load (1.4ms)  SELECT "sales_metrics".* FROM "sales_metrics" WHERE "sales_metrics"."measured_id" = $1 AND "sales_metrics"."measured_type" = $2 AND "sales_metrics"."metric_type" = $3 AND (value_cents > 0)  ORDER BY "sales_metrics"."value_cents" DESC  [["measured_id", 21334], ["measured_type", "BiCustomer"], ["metric_type", 0]]


  has_many :companies, foreign_key: "bi_customer_no", primary_key:'no'

  belongs_to :bi_outside_sales_rep
  belongs_to :bi_inside_sales_rep

  has_many :initiative_targets, as: :targetted
    has_many :initiatives, through: :initiative_targets

    has_many :bi_quotes
    has_many :bi_orders



  def company
    return companies.last
  end

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
    return sales_metrics.where(metric_type: SalesMetric.metric_types[:customer_sales] ).where('value_cents > ?',0)
  end

  def getTotalCostsMetricsPerVendor
    return sales_metrics.where(metric_type: SalesMetric.metric_types[:customer_costs]  ).where('value_cents > ?',0)
  end



  def getTotalSalesMetricsWithVendor(vend)
    return sales_metrics.where(metric_type: SalesMetric.metric_types[:customer_sales], bi_vendor_no: vend.no)
  end

  def getTotalCostsMetricsWithVendor(vend)
    return sales_metrics.where(metric_type: SalesMetric.metric_types[:customer_costs], bi_vendor_no: vend.no  )
  end


end

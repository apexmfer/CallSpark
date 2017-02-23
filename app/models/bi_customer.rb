class BiCustomer < ActiveRecord::Base
  validates :no, presence: true, uniqueness:true

  has_many :company#, foreign_key: "bi_customer_no"

  belongs_to :bi_outside_sales_rep
  belongs_to :bi_inside_sales_rep

  has_many :initiative_targets, as: :targetted
    has_many :initiatives, through: :initiative_targets


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
end

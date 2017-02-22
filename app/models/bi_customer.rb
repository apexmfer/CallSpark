class BiCustomer < ActiveRecord::Base
  validates :no, presence: true, uniqueness:true

  has_many :company#, foreign_key: "bi_customer_no"

  belongs_to :bi_outside_sales_rep
  belongs_to :bi_inside_sales_rep
end

class BiOutsideSalesRep < ActiveRecord::Base
    validates :code, presence: true, uniqueness:true
      has_many :bi_customers
end

class BiOrder < ActiveRecord::Base
    validates :order_number, presence: true #do not need uniqueness since these are line items
    validates :order_number, uniqueness: { scope: :line_number }

 belongs_to :bi_vendor,  foreign_key: :bi_vendor_no
end

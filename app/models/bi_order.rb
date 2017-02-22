class BiOrder < ActiveRecord::Base
    validates :order_number, presence: true #do not need uniqueness since these are line items
end

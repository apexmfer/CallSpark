class BiOrder < ActiveRecord::Base
    validates :order_number, presence: true 
end

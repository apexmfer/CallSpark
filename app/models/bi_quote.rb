class BiQuote < ActiveRecord::Base

   validates :order_number, uniqueness: { scope: :line_number }

end

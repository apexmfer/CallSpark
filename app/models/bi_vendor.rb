class BiVendor < ActiveRecord::Base
    validates :no, presence: true, uniqueness:true
end

class BiCustomer < ActiveRecord::Base
  validates :no, presence: true, uniqueness:true
end

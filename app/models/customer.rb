class Customer < ActiveRecord::Base
   attr_accessible :name, :company, :phone_number, :email
end

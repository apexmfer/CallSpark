class Call < ActiveRecord::Base
 attr_accessible :customer_id,:category_id,:text
 
 def getCustomerName
   
   customer = Customer.where(id: customer_id).first
   
   if(customer != nil)
       return customer.name
    else
      return "N/A"
   end
   
  
 end

end

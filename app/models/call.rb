class Call < ActiveRecord::Base
 attr_accessible :customer_id,:category_id,:text,:user_id

 def getCustomerName

   customer = Customer.where(id: customer_id).first

   if(customer != nil)
       return customer.name
    else
      return "?"
   end


 end

  def getCustomer

   return Customer.where(id: customer_id).first

 end

 def getUser

   return User.where(id: user_id).first

 end


  

  def getCategoryName

   category = Category.where(id: category_id).first

   if(category != nil)
       return category.name
    else
      return ""
   end


 end

end

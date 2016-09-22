require 'elasticsearch/model'

class Call < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

 attr_accessible :customer_id,:category_id,:text,:user_id

 belongs_to :region
 belongs_to :customer
  belongs_to :user
   belongs_to :category

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

 def getSanitizedText
  return ActionController::Base.helpers.strip_tags(text).html_safe
 end


  def getCategoryName

   category = Category.where(id: category_id).first

   if(category != nil)
       return category.name
    else
      return ""
   end


 end

  def getCompanyName


   if(getCustomer != nil)
       return getCustomer.getCompanyName
    else
      return ""
   end


 end



end

Call.import # for auto sync model with elastic search

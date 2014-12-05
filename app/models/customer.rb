class Customer < ActiveRecord::Base
   attr_accessible :name, :company_id, :phone_number, :email
   
    def company
      
      return Company.where(id: company_id).first
  
      
  
    end
   
end

class CustomerController < ApplicationController
  
  def update
    
    
    companyname = params['customer']['companyname']
    phone = params['customer']['phone_number']
    email = params['customer']['email']
    
    
    company = Company.where(name: companyname).first
    
    if(company == nil)
       company = Company.new(name: companyname)
       company.save  
    end
    
    
    customer = Customer.find(params['id'])
    customer.phone_number = phone
    customer.email = email
    customer.company_id = company.id    
    customer.save
    
    redirect_to '/customer', alert: 'Customer updated'
  end
  
   def destroy
    #render text: params
    Customer.find(params["id"]).destroy


     redirect_to '/customer', alert: 'Customer destroyed'
  
  end
  
  
  
  
end

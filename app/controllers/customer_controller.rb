class CustomerController < ApplicationController
  
  
  
  
  
  
  def create
    
    @customer = spawnCustomer( params[:customer])
    
    redirect_to @customer
  end
  
  
  
  def update
    
    name = params['customer']['name']
    companyname = format_as_company_name(params['customer']['companyname'])
    strippedphone = params['customer']['phone_number'].gsub(/\D/, '')
    phone = number_to_phone( strippedphone,   area_code: (strippedphone.length > 9))  #strips all but numbers from the input and then formats as phone number
   email = params['customer']['email'].humanize.delete(' ') 
    notes = sentencify(params['customer']['notes'])
    
    company = Company.where(name: companyname).first
    companyMatchNil = (company == nil)
    
    if companyMatchNil and companyname.length >= 1
       company = Company.new(name: companyname)
       company.save  
    end
    
    
    customer = Customer.find(params['id'])
    customer.name = name
    customer.phone_number = phone
    customer.email = email
    
    if(company != nil)
    customer.company_id = company.id    
    end
    
    customer.notes = notes    
    customer.save
    
    redirect_to customer
  end
  
   def destroy
    #render text: params
    Customer.find(params["id"]).destroy


     redirect_to '/customer', alert: 'Customer destroyed'
  
  end
  
  
  
  
end

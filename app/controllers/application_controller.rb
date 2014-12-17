class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_login
  
  
  private
def not_authenticated
  redirect_to login_path, alert: "Please login first"
end



  #This creates a new customer with a form and does special checks to make a new company
  def spawnCustomer(params )
    
    #Try to find existing matches first
    customer = Customer.where(name: params[:caller]).first
    
    company = Company.where(name: params[:company]).first
    
    
    #If there is no company match, store this info and make a brand new company record
    companyMatchNil = (company == nil)
    
      if companyMatchNil
        
        company = Company.new(:name => params[:company],
        :BPID => params[:BPID]
        )
         company.save
      end
      
    
    
    #If the customer is brand new or if (the company is new and the customer has no last name) then make a new customer
    #This prevents overwriting other existing customers when somebody is added with no last name
    if customer == nil or (customer.noLastName and companyMatchNil)
      
      
            
      customer = Customer.new(:name => params[:caller],
     :company_id => company.id,
      :phone_number => params[:phone],
      :email => params[:email]
      )
      
    else
      
      #Update the existing customer info
      if( company != nil )
       customer.company_id =  company.id;
      end
    
     customer.phone_number =  params[:phone];
     customer.email =  params[:email];
      
    end
    
    #save our updates
    customer.save 
    
        if( company != nil )
        company.save
         end
         
         
         
         
    
    
    return customer
  end
  
  
  
  
  
  
  
  
  
  
  
  
  


end

class CustomerController < ApplicationController
  
  
  
   def destroy
    #render text: params
    Customer.find(params["id"]).destroy


     redirect_to '/customer', alert: 'Customer destroyed'
  
  end
  
  
  
  
end

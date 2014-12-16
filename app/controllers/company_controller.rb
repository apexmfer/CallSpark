class CompanyController < ApplicationController
  
  
  
  def destroy
      Company.find(params["id"]).destroy
  

      redirect_to '/company', alert: 'Company destroyed'
    
  end
  
  
  
end

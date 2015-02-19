class CompanyController < ApplicationController
  
    def update
        name = params['company']['name']
        bpid = params['company']['BPID']
      
      
      matchingCompany = Company.find(params['id'])
     # matchingCompany = Company.where(:name => name).first
      
      if(matchingCompany != nil)
        company.name = name;
        company.BPID = bpid;      
        company.save
        redirect_to company, notice: 'Company updated'
      else
         redirect_to '/company', alert: 'No company match found!'
      end
      
    end
  
  def destroy
      Company.find(params["id"]).destroy
  

      redirect_to '/company', alert: 'Company destroyed'
    
  end
  
  
  
end

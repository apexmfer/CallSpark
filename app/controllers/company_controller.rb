class CompanyController < ApplicationController
  
    def update
        name = params['company']['name']
        bpid = params['company']['BPID']
      
      
      company = Company.find(params['id'])
      matchingCompany = Company.where(:name => name).first
      
      if(matchingCompany == nil)
        company.name = name;
        company.BPID = bpid;      
        company.save
        redirect_to company, notice: 'Company updated'
      else
         redirect_to '/company', alert: 'A company already exists with that name!'
      end
      
    end
  
  def destroy
      Company.find(params["id"]).destroy
  

      redirect_to '/company', alert: 'Company destroyed'
    
  end
  
  
  
end

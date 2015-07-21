class CompanyController < ApplicationController


  def data

      companies = Company.paginate(:page => (params[:offset].to_i+1),
      :per_page => params[:limit])

      output = {:total => companies.length, :rows => companies}

         render :json => output
  end

    def update
        name = params['company']['name']
        bpid = params['company']['BPID']


      matchingCompany = Company.find(params['id'])
     # matchingCompany = Company.where(:name => name).first

      if(matchingCompany != nil)
        matchingCompany.name = name;
        matchingCompany.BPID = bpid;
        matchingCompany.save
        redirect_to matchingCompany, notice: 'Company updated'
      else
         redirect_to '/company', alert: 'No company match found!'
      end

    end

  def destroy
      Company.find(params["id"]).destroy


      redirect_to '/company', alert: 'Company destroyed'

  end



end

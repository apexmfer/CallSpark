class CompanyController < ApplicationController


  def data

      companies = Company.offset(params[:offset]).limit(params[:limit])

      if(params[:search] && params[:search].length > 0)
          companies = Company.where("name LIKE ?", params[:search])
      end

      output = {:total => Company.all.length, :rows => companies}

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

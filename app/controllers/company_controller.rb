class CompanyController < ApplicationController
   before_filter :require_login, except: [:index,:show,:data]



  def show
    @company = Company.find(params["id"])
    @calls = @company.calls.order("created_at" + " DESC").paginate(:page => params[:call_page], :per_page => 10)
    @customers = @company.customers
    @projects = @company.projects.order("updated_at" + " DESC").paginate(:page => params[:project_page], :per_page => 10)

  end

  def edit

    @company = Company.find(params["id"])



    if @company.bi_customer == nil
      @similar_bi_customers = @company.findCloseMatchBICustomers
    end


  end



  def data



      companies = Company.offset(params[:offset]).limit(params[:limit])

      if(params[:search] && params[:search].length > 0)
          companies = Company.where("name LIKE ?", params[:search])
      end

      if(params[:sort] && params[:sort].length > 0)
          companies = companies.order(params[:sort] + " " + params[:order])
      end

      output = {:total => Company.all.length, :rows => companies}

         render :json => output
  end

    def update
        name = params['company']['name']
        address = params['company']['address']
        bpid = params['company']['BPID']


      matchingCompany = Company.find(params['id'])
     # matchingCompany = Company.where(:name => name).first

      if(matchingCompany != nil)
        matchingCompany.name = name;
        matchingCompany.address = address;
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

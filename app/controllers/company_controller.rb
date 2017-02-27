class CompanyController < ApplicationController
   before_filter :require_login, except: [:index,:show,:data]

    include CompanyHelper

  def show
    @company = Company.find(params["id"])
    @calls = @company.calls.order("created_at" + " DESC").paginate(:page => params[:call_page], :per_page => 10)
    @customers = @company.customers
    @projects = @company.projects.order("updated_at" + " DESC").paginate(:page => params[:project_page], :per_page => 10)
    @available_product_segments = ProductSegment.all


    @bi_customer = @company.bi_customer
    p 'comp sales met 2'
    if @bi_customer
      p 'comp sales met 3'
        p  @bi_customer.no
      @sales_metrics = @bi_customer.getTotalSalesMetricsPerVendor.order(value_cents: :DESC)
      @costs_metrics = @bi_customer.getTotalCostsMetricsPerVendor.order(value_cents: :DESC)
        p @sales_metrics

      @total_spend = 0
      @sales_metrics.each do |metric|
        @total_spend += metric.value
      end
    end
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


     @company = Company.find(params['id'])
      # @company = Company.where(:name => name).first



      if(@company != nil)


        @updated = @company.update_attributes(company_params)


        if ( @updated )

          assignBestMatchingBiCustomerToCompany(@company)

          redirect_to @company, notice: 'Company updated'
        else
          render text: @company.errors.full_messages
        end

      else
         redirect_to '/company', alert: 'No company match found!'
      end

    end

  def destroy
      Company.find(params["id"]).destroy


      redirect_to '/company', alert: 'Company destroyed'

  end

  def company_params
   params.require(:company).permit(:name,:address,:BPID, focused_product_segments_attributes: [:id, :focused_id, :focused_type, :product_segment_id, :_destroy])
 end

end

class BiVendorController < ApplicationController
  before_filter :require_login, except: [:index,:show,:data]
  def index
  end

  def show
    @vendor = BiVendor.find_by_no(params[:id])


    @sales_metrics = @vendor.getTotalSalesMetricsPerCustomer
    @costs_metrics = @vendor.getTotalCostsMetricsPerCustomer
  end

  def data

      vendors = BiVendor.offset(params[:offset]).limit(params[:limit])

      if(params[:search] && params[:search].length > 0)
          vendors = BiVendor.where("name LIKE ?", params[:search])
      end

      if(params[:sort] && params[:sort].length > 0)
          vendors = vendors.order(params[:sort] + " " + params[:order])
      end

      output = {:total => BiVendor.all.length, :rows => vendors}

         render :json => output
  end

end

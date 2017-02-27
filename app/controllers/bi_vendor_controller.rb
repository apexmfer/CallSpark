class BiVendorController < ApplicationController
  before_filter :require_login, except: [:index,:show,:data]
  def index
  end

  def show
    @vendor = BiVendor.find_by_no(params[:id])


    @sales_metrics = @vendor.getTotalSalesMetricsPerCustomer.order(value_cents: :DESC)
    @costs_metrics = @vendor.getTotalCostsMetricsPerCustomer.order(value_cents: :DESC)
  #  @sales_metrics = @vendor.sales_metrics.order(value_cents: :DESC)
    @available_product_segments = ProductSegment.all


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

  def update
    @vendor = BiVendor.find(params[:id])
    @updated = @vendor.update_attributes(bi_vendor_params)

  respond_to do |format|
    if @updated
      format.html { redirect_to(@vendor, :notice => 'Vendor was successfully updated.') }
      format.xml  { head :ok }
    else
      format.html { render :action => "edit" }
      format.xml  { render :xml => @vendor.errors, :status => :unprocessable_entity }
    end
  end
  end


  def bi_vendor_params
   params.require(:bi_vendor).permit(:name,  focused_product_segments_attributes: [:id, :focused_id, :focused_type, :product_segment_id, :_destroy])
 end
end

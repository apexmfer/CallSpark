class InitiativeController < ApplicationController
  def show
    @initiative = Initiative.find_by_id(params[:id])

    @available_product_segments = ProductSegment.all
    @product_segments = @initiative.focused_product_segments

    @target_companies = @initiative.bi_target_companies

    @target_vendors = @initiative.bi_target_vendors
  end

  def index
    @sort_by = "updated_at"
    if params[:sort_by]
      @sort_by = params[:sort_by]
      @order_style = "ASC"
    end

    if @sort_by == "updated_at" then   @order_style = "DESC" end

    @initiatives = Initiative.order(  @sort_by => @order_style )#.paginate(:page => params[:page], :per_page => 10)


  end

  def update
    @initiative = Initiative.find(params[:id])
    @updated = @initiative.update_attributes(initiative_params)
    @initiative.updateTargetsBasedOnProductSegments

  respond_to do |format|
    if @updated
      format.html { redirect_to(@initiative, :notice => 'Initiative was successfully updated.') }
      format.xml  { head :ok }
    else
      format.html { render :action => "edit" }
      format.xml  { render :xml => @initiative.errors, :status => :unprocessable_entity }
    end
  end
  end


  def initiative_params
   params.require(:initiative).permit(:name,  focused_product_segments_attributes: [:id, :focused_id, :focused_type, :product_segment_id, :_destroy])
 end
end

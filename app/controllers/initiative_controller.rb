class InitiativeController < ApplicationController
  def show
    @initiative = Initiative.find_by_id(params[:id])


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
end

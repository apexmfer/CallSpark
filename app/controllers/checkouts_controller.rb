class CheckoutsController < ApplicationController
    before_filter :require_login


    def new
      @new_checkout = Checkout.new
  end

  def index
  end

  def create

    if params[:checkout][:description]
      description = sentencify(params[:checkout][:description])
      description = description.gsub(/&Amp;/,"").gsub(/&Nbsp;/,"").gsub(/Amp;/,"").gsub(/Nbsp;/,"")
    end 



    @customer = spawnCustomer(params[:customer],params[:company],params[:phone],params[:email],nil,nil)


    @checkout = Checkout.new(new_checkout_params)


      @checkout.save
      redirect_to @checkout

  end


  private
    def new_checkout_params
      params.require(:checkout).permit(:barcode)
    end
end

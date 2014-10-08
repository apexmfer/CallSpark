class CallsController < ApplicationController
  
  def new
     
  end
  
  def update
    customername = params['id'];
    
    customer = Customer.where( :name => customername).first
    
    render json: customer
  end
  
  def create
    #render text: params[:call].inspect
    
    @customer = Customer.where(name: call_params[:customername]).first
    
    if @customer == nil
      @customer = Customer.new(:name => params[:call][:caller],
     :company => params[:call][:company] ,
      :phone_number => params[:call][:phone],
      :email => params[:call][:email]
      )
    end
    
    @customer.save
    
    
  
    @call = Call.new(:customer_id => @customer.id,
     :text => params[:call][:text] 
    
      )
 
  @call.save
  redirect_to @call
  
  end
  
  
  
private
  def call_params
    params.require(:call).permit(:customer_id, :text)
  end
   def customer_params
    params.require(:customer).permit(:name, :company,:phone_number,:email)
  end
  
          
  
end

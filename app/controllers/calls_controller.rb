class CallsController < ApplicationController
  
  def new
     
  end
  
    def listinfo
    customername = params['id'];
    
    customer = Customer.where( :name => customername).first
    
    data = [customer,customer.company]
    
    render json: data
  end
  
  
  def update
    text = sentencify(params['call']['text'])
    
     call = Call.find(params['id'])    
     

    call.text = text 
    call.save
    
    
    redirect_to call
  end
  
    def history
    customername = params['id'];
    
    customer = Customer.where( :name => customername).first
    
    render json: Call.where(customer_id: customer.id).reverse
  end
  
  def create
    #render text: params[:call].inspect
        text = sentencify(params[:call][:text])
    
    @customer = spawnCustomer( params[:call])
       
         
  
    @call = Call.new(:customer_id => @customer.id,
    :category_id => params[:call][:category_id],
     :text => text,
     :user_id => current_user.id
    
      )
 
  @call.save
  redirect_to @call
  
  end
  
  def destroy
      Call.find(params["id"]).destroy
  

      redirect_to '/calls', alert: 'Call destroyed'
    
  end
  
private
  def call_params
    params.require(:call).permit(:customer_id, :text)
  end
   def customer_params
    params.require(:customer).permit(:name, :company,:phone_number,:email)
  end
  
          
  
end

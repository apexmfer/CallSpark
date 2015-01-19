class CallsController < ApplicationController
  
  def new
     
  end
  
    def listinfo
    id = params['id']
    
    customer = Customer.find_by_id( id)
    
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
     id = params['id']
    
    customer = Customer.find_by_id( id)
    
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

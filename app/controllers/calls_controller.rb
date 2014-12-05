class CallsController < ApplicationController
  
  def new
     
  end
  
  def update
    customername = params['id'];
    
    customer = Customer.where( :name => customername).first
    
    data = [customer,customer.company]
    
    render json: data
  end
  
    def history
    customername = params['id'];
    
    customer = Customer.where( :name => customername).first
    
    render json: Call.where(customer_id: customer.id).reverse
  end
  
  def create
    #render text: params[:call].inspect
    
    @customer = Customer.where(name: params[:call][:caller]).first
    @company = Company.where(name: params[:call][:company]).first
    
    
    if @customer == nil
      
      
      
      if @company == nil
        
        @company = Company.new(:name => params[:call][:company],
        :BPID => params[:call][:BPID],
        )
         @company.save
      end
      
      
      
      @customer = Customer.new(:name => params[:call][:caller],
     :company_id => @company.id,
      :phone_number => params[:call][:phone],
      :email => params[:call][:email]
      )
      
    else
      
    @customer.company_id =  @company.id;
     @customer.phone_number =  params[:call][:phone];
     @customer.email =  params[:call][:email];
      
    end
    
    @customer.save
    
   
  
    @call = Call.new(:customer_id => @customer.id,
    :category_id => params[:call][:category_id],
     :text => params[:call][:text],
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

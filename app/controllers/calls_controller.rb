class CallsController < ApplicationController


    def data

        calls = Call.offset(params[:offset]).limit(params[:limit])

        customCallData = Array.new

        calls.all.each do |call|
          thiscaller = call.getCustomerName
          thisresponder = call.getUser.name
          thiscategory = call.getCategoryName

          customCallData.push({:id => call.id,:caller => thiscaller, :responder => thisresponder, :category => thiscategory, :timeago => call.created_at})
        end


        output = {:total => Call.all.length, :rows => customCallData}

           render :json => output
    end


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

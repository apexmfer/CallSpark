class CallsController < ApplicationController
   before_filter :require_login, except: [:index,:show,:data]

   def show


      @call = Call.find_by_id(params[:id])

   end

    def data



      calls = Call.offset(params[:offset]).limit(params[:limit])

      if params[:sort] == "company"
        params[:sort] = "company_id"
      end

      if params[:sort] == "customer"
        params[:sort] = "customer_id"
      end

      if params[:sort] == "responder"
        params[:sort] = "user_id"
      end

      if params[:sort] == "category"
        params[:sort] = "category_id"
      end

      if params[:sort] == "timeago"
        params[:sort] = "created_at"
      end


        if(params[:sort] && params[:sort].length > 0)
          calls = calls.order(params[:sort] + " " + params[:order])
        end



        @calls = calls.map{|call|
          {:id => call.id, :company => call.getCompanyName, :customer => call.getCustomerName, :responder => call.getUser.name, :category => call.getCategoryName, :timeago => call.created_at  }
        }

        output = {:total => Call.all.length, :rows => @calls}

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

  def edit


    @call = Call.find_by_id(params[:id])

    @customer = @call.getCustomer





  end

  def update
    text = sentencify(params['text'])



     call = Call.find(params['id'])

     #remove the garbage ampersand and blank space tags that get made
    call.text = text.gsub(/&Amp;/,"").gsub(/&Nbsp;/,"").gsub(/Amp;/,"").gsub(/Nbsp;/,"")
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

        text = text.gsub(/&Amp;/,"").gsub(/&Nbsp;/,"").gsub(/Amp;/,"").gsub(/Nbsp;/,"")

          p params

    @customer = spawnCustomer(params[:call][:caller],params[:call][:company],params[:call][:phone],params[:call][:email],params[:call][:region_id],params[:call][:BPID])



    @call = Call.new(:customer_id => @customer.id,
    :category_id => params[:call][:category_id],
     :text => text,
     :user_id => current_user.id,
     :region_id => params[:call][:region_id]

      )

  if @call.save

    @outside_sales_rep = @call.getOutsideSalesRep

    if @outside_sales_rep and @outside_sales_rep.getUser
      OutsideSalesMailer.outside_sales_email(@outside_sales_rep.getUser,@call).deliver
    end

    redirect_to @call

  end

  end

  def destroy
      Call.find(params["id"]).destroy


      redirect_to '/calls', alert: 'Call destroyed'

  end

private
  def call_params
    params.require(:call).permit(:customer_id, :text, :region_id)
  end
   def customer_params
    params.require(:customer).permit(:name, :company,:phone_number,:email, :region_id)
  end



end

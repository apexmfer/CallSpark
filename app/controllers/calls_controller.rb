class CallsController < ApplicationController
   before_action :require_login, except: [:index,:show,:data]

   def show


      @call = Call.find_by_id(params[:id])

      #render 'show'

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

        p 'calll create params are'
        p params

    @customer = findOrCreateNewCustomer(
      params[:call][:caller],
      params[:call][:job_role_id],
      params[:call][:company],
      params[:call][:origin_type]
      params[:call][:phone],
      params[:call][:email],
      params[:call][:region_id],
      params[:call][:BPID],
      params[:call][:mcmc_account_number],
      params[:call][:account_manager_id],
      params[:call][:service_contract_type]
    )

    if @customer == nil
      p 'NIL CUSTOMER '
      return
    end

    p 'customer is '
    p @customer

    @called_at_time = params[:call][:called_at]

    if(@called_at_time == nil)
      @called_at_time = DateTime.current.to_date
    end


    #notes text for call
    text = sentencify(params[:call][:text])
    text = text.gsub(/&Amp;/,"").gsub(/&Nbsp;/,"").gsub(/Amp;/,"").gsub(/Nbsp;/,"")



    @call = Call.new(
      :customer_id => @customer.id,
      :origin_type => params[:call][:origin_type],
      :called_at => @called_at_time,
     :category_id => params[:call][:category_id],
     :text => text,
     :user_id => current_user.id,
     :region_id => params[:call][:region_id],
     :initiative_id => params[:call][:initiative_id],
     :product_vendor_id => params[:call][:product_vendor_id],
     :question_for_call => params[:call][:question_for_call],
     :resolution_for_call => params[:call][:resolution_for_call]

      )

      if @call.save!

        @outside_sales_rep = @call.getOutsideSalesRep

        if @outside_sales_rep and @outside_sales_rep.getUser and @outside_sales_rep.getUser.receive_outside_sales_emails
          OutsideSalesMailer.outside_sales_email(@outside_sales_rep.getUser,@call).deliver
        end

        redirect_to @call

      else
            p 'ERROR'
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

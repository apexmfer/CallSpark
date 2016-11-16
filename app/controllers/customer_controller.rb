class CustomerController < ApplicationController
   before_filter :require_login, except: [:index,:show,:data]



  def data

      customers = Customer.offset(params[:offset]).limit(params[:limit])

      if(params[:search] && params[:search].length > 0)
        customers = Customer.where("name LIKE ?", params[:search])
      end

      if(params[:sort] && params[:sort].length > 0)
        customers = customers.order(params[:sort] + " " + params[:order])
      end

      output = {:total => Customer.all.length, :rows => customers}

         render :json => output
  end


  def create

    @customer = spawnCustomer( params[:customer])

    redirect_to @customer
  end



  def update

    name = params['customer']['name']
    companyname = format_as_company_name(params['customer']['companyname'])
    strippedphone = params['customer']['phone_number'].gsub(/\D/, '')
    phone = strippedphone  #strips all but numbers from the input and then formats as phone number
   email = params['customer']['email'].humanize.delete(' ')

   if params['customer']['notes']
    notes = sentencify(params['customer']['notes'])
  end

    company = Company.where(name: companyname).first
    companyMatchNil = (company == nil)

    if companyMatchNil and companyname.length >= 1
       company = Company.new(name: companyname)
       company.save
    end


    customer = Customer.find(params['id'])
    customer.name = name
    customer.phone_number = phone
    customer.email = email

    if(company != nil)
    customer.company_id = company.id
    end

    customer.notes = notes
    customer.save

    redirect_to customer
  end

   def destroy
    #render text: params
    Customer.find(params["id"]).destroy


     redirect_to '/customer', alert: 'Customer destroyed'

  end




end

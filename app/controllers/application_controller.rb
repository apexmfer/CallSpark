class ApplicationController < ActionController::Base
  protect_from_forgery

   before_action :init_variables


  private
def not_authenticated
  redirect_to login_path, alert: "Please login first"
end



include ActionView::Helpers::NumberHelper

  def init_variables
    @show_dashboard_button = (current_user and current_user.instance_of?(User) and !current_user.favorite_companies.empty?)
  end

  def sentencify(input)
    if input
      return input.gsub(/([a-z])((?:[^.?!]|\.(?=[a-z]))*)/i) { $1.upcase + $2.rstrip }
    end
  end

  def capFirstLetter(word)

    word[0] = word[0].upcase

    return word

  end


  def format_as_company_name(input)

    return input.split(" ").map{|word| capFirstLetter(word)}.join(" ")

  end


  #This creates a new customer with a form and does special checks to make a new company
  def spawnCustomer(customer_name, job_role_id, company_name, raw_phone, raw_email, region_id, bpid  )
    p 'spawn customer'
    p customer_name
    p company_name


    callername = (customer_name).titleize
    companyname = format_as_company_name(company_name)

    strippedphone = raw_phone.gsub(/\D/, '')
    phone = number_to_phone( strippedphone,   area_code: (strippedphone.length > 9))  #strips all but numbers from the input and then formats as phone number
    email = (raw_email).humanize.delete(' ')
      #region_id = (params[:region_id])
      #bpid = params[:BPID]

    #Try to find existing matches first
    customer = Customer.where(name: callername).first

    company = Company.where(name: companyname).first


    #If there is no company match, store this info and make a brand new company record
    companyMatchNil = (company == nil)

      if companyMatchNil and companyname.length >= 1

        company = Company.new(:name => companyname,
        :BPID => bpid
        )

           company.save


      end



    #If the customer is brand new or if (the company is new and the customer has no last name) then make a new customer
    #This prevents overwriting other existing customers when somebody is added with no last name
    if customer == nil or (customer.noLastName and companyMatchNil)

     company_id = nil
      if company
        company_id = company.id
      end

      customer = Customer.new(:name => callername,
      :company_id => company_id,
      :job_role_id => job_role_id,
      :phone_number => phone,
      :email => email,
      :region_id => region_id
      )

    else

      #Update the existing customer info
      if( company != nil )
       customer.company_id =  company.id;
      end

     customer.job_role_id = job_role_id;
     customer.phone_number =  phone;
     customer.email = email;
     customer.region_id = region_id;

    end

       company.save!
    #save our updates
    customer.save!

        if( company != nil )
           company.save
         end



    return customer
  end









end

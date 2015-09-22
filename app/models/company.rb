class Company < ActiveRecord::Base
  # attr_accessible :title, :body
   

  def as_json(options = { })
    h = super(options)
    h[:callcount]   = callcount
    h
 end

 def callcount


    employeecount = 0
    callcount = 0

    Customer.where(company_id: id).each do |cust|
      employeecount = employeecount + 1

      callcount += Call.where(customer_id: cust.id).length
    end


  callcount
 end

end

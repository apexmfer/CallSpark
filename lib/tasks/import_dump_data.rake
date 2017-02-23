
#this runs every night thanks to Cron and Whenever gem!
require 'date'


namespace :db do

  desc 'try to connect'
  task import_and_process_dump_data: :environment do

    #wipe_business_data()
    import_business_data()
    process_business_data()



  end

  desc 'process the data'
  task process_dump_data: :environment do

    process_business_data()

  end

  desc 'process the data'
  task import_dump_data: :environment do

    import_business_data()

  end
end


def wipe_business_data
  p 'deleting all business data... '
   BiQuote.destroy_all
   BiOrder.destroy_all
   BiCustomer.destroy_all
   BiVendor.destroy_all
  p 'deleted all business data. '
end


def import_business_data()

  #use a loop for this .. loop through each day and import a day at a time




      p 'importing business data... '


    p 'established connection'
    p 'established importing open orders'

    query_date_start = (Date.today - 2.months)
    query_date_end = (Date.today)


    (query_date_start..query_date_end).each do |date|

      p "Importing date " + date.to_s + "."


      query_date_min = date
      query_date_max = date + 1.day

      query_date_min_formatted = date.strftime("%m/%d/%Y")
      query_date_max_formatted = date.strftime("%m/%d/%Y")



        #SQL SERVER Syntax


        #IMPORT THE QUOTES FOR THIS DAY


        @connection = ActiveRecord::Base.establish_connection('sqlserver')


        sql = "SELECT *
         FROM Quote_OrdersVW
         WHERE EnterDate >= '"+query_date_min_formatted+"'
         AND EnterDate <= '"+query_date_max_formatted+"' "


         @result = @connection.connection.select_all(sql);
        # p @result.as_json

         number_of_rows = 0

         @result.each do |row|
            createBIQuoteFromSQLOutput( row )
            number_of_rows+=1
         end

         p "Imported " + number_of_rows.to_s + " rows of quotes."




        #IMPORT THE ORDERS FOR THIS DAY


                 @connection = ActiveRecord::Base.establish_connection('sqlserver')

      sql = "SELECT *
       FROM Open_OrdersVW
       WHERE EnterDate >= '"+query_date_min_formatted+"'
       AND EnterDate <= '"+query_date_max_formatted+"' "


       @result = @connection.connection.select_all(sql);
      # p @result.as_json

       number_of_rows = 0

       @result.each do |row|
          createBIOrderFromSQLOutput( row )
          number_of_rows+=1
       end

       p "Imported " + number_of_rows.to_s + " rows of orders."

    end

end

def createBIOrderFromSQLOutput(sql_row)
#  p 'creating bi order from output '


 @connection = ActiveRecord::Base.establish_connection('development')




  bi_outside_sales_rep = BiOutsideSalesRep.find_or_create_by(  #make sure no dup
    "code"=> sql_row["OutsideSlsrep"],
    "name"=> sql_row["OutsideSlsrepName"]
  )

  bi_inside_sales_rep = BiInsideSalesRep.find_or_create_by(  #make sure no dup
    "code"=> sql_row["InsideSlsrep"],
    "name"=> sql_row["InsideSlsrepName"]
  )


      bi_customer = BiCustomer.find_or_create_by(  #make sure no dup
        "no"=> sql_row["CustomerNo"].to_f.floor,
        "name"=> sql_row["CustomerName"]
      )

      #For every bi_customer, set the outside and inside reps (then we can send emails )
      if bi_customer
        if bi_outside_sales_rep
          bi_customer.update_attributes(bi_outside_sales_rep_id: bi_outside_sales_rep.id )
        end
        if bi_inside_sales_rep
          bi_customer.update_attributes(bi_inside_sales_rep_id: bi_inside_sales_rep.id)
        end
      end

      bi_vendor = BiVendor.find_or_create_by(  #make sure no dup
        "no"=> sql_row["VendorNo"].to_f.floor,
        "name"=> sql_row["VendorName"]
      )

  #RangeError: 999999999999 is out of range



  new_order = BiOrder.new(
    "order_number"=>sql_row["OrderNumber"],
    "order_suffix"=>sql_row["OrderSuffix"],
    "line_number"=>sql_row["LineNumber"],
    "ship_prod"=>sql_row["ShipProd"],
    "warehouse"=>sql_row["Warehouse"],
    "prod_desc"=>sql_row["ProdDesc"],
    "prod_cost_cents"=>stringMoneyToCents(sql_row["ProdCost"]),
    "price_cents"=>stringMoneyToCents(sql_row["Price"]),
    "sales_cents"=>stringMoneyToCents(sql_row["Sales"]),
    "bi_customer_no"=> bi_customer.no,
    "customer_po"=> sql_row["CustomerPO"],
    "ship_to_name"=>sql_row["ShipToName"],
    "ship_to_address1"=>sql_row["ShipToAddress1"],
    "ship_to_city"=>sql_row["ShipToCity"],
    "ship_to_state"=>sql_row["ShipToState"],
    "bi_inside_sales_rep_id"=>bi_inside_sales_rep.id,
    "bi_outside_sales_rep_id"=>bi_outside_sales_rep.id,
    "prod_category"=>sql_row["ProdCategory"],
    "bi_vendor_no"=>bi_vendor.no,
    "qty_ord"=>sql_row["QtyOrd"].to_f.floor,
    "enter_date"=> stringToDatetime(sql_row["EnterDate"]),
    "promise_date"=> stringToDatetime(sql_row["PromiseDate"]),
    "request_date"=> stringToDatetime(sql_row["RequestDate"])
    #ship date?
  )


  if(new_order.save)
    #p 'saved: ' + new_order.to_s

  else
    p 'not able to save: ' + new_order.errors.full_messages.to_s
  end

end

def createBIQuoteFromSQLOutput(sql_row)
#  p 'creating bi quote from output '


 @connection = ActiveRecord::Base.establish_connection('development')




  bi_outside_sales_rep = BiOutsideSalesRep.find_or_create_by(  #make sure no dup
    "code"=> sql_row["OutsideSlsrep"],
    "name"=> sql_row["OutsideSlsrepName"]
  )

  bi_inside_sales_rep = BiInsideSalesRep.find_or_create_by(  #make sure no dup
    "code"=> sql_row["InsideSlsrep"],
    "name"=> sql_row["InsideSlsrepName"]
  )


  bi_customer = BiCustomer.find_or_create_by(  #make sure no dup
    "no"=> sql_row["CustomerNo"].to_f.floor,
    "name"=> sql_row["CustomerName"]
  )

  bi_vendor = BiVendor.find_or_create_by(  #make sure no dup
    "no"=> sql_row["VendorNo"].to_f.floor,
    "name"=> sql_row["VendorName"]
  )


  new_quote = BiQuote.new(
    "order_number"=>sql_row["OrderNumber"],
    "order_suffix"=>sql_row["OrderSuffix"],
    "line_number"=>sql_row["LineNumber"],
    "ship_prod"=>sql_row["ShipProd"],
    "warehouse"=>sql_row["Warehouse"],
    "prod_desc"=>sql_row["ProdDesc"],
    "prod_cost_cents"=>stringMoneyToCents(sql_row["ProdCost"]),
    "price_cents"=>stringMoneyToCents(sql_row["Price"]),
    "sales_cents"=>stringMoneyToCents(sql_row["Sales"]),
    "bi_customer_no"=> bi_customer.no,
    "customer_po"=> sql_row["CustomerPO"],
    "ship_to_name"=>sql_row["ShipToName"],
    "ship_to_address1"=>sql_row["ShipToAddress1"],
    "ship_to_city"=>sql_row["ShipToCity"],
    "ship_to_state"=>sql_row["ShipToState"],
    "bi_inside_sales_rep_id"=>bi_inside_sales_rep.id,
    "bi_outside_sales_rep_id"=>bi_outside_sales_rep.id,
    "prod_category"=>sql_row["ProdCategory"],
    "bi_vendor_no"=>bi_vendor.no,
    "qty_ord"=>sql_row["QtyOrd"].to_f.floor,
    "enter_date"=> stringToDatetime(sql_row["EnterDate"]),
    "promise_date"=> stringToDatetime(sql_row["PromiseDate"]),
    "request_date"=> stringToDatetime(sql_row["RequestDate"])
    #ship date?
  )


  if(new_quote.save)
  #  p 'saved: ' + new_quote.to_s

  else
    p 'not able to save: ' + new_quote.errors.full_messages.to_s
  end

end



def stringToDatetime(date_string)
  if date_string
    return  (date_string)
  end
  return nil
end

  # input is like "320.94"
def stringMoneyToCents(string_money)
  float_money = (string_money).to_f
  float_cents = float_money * 100.0
  return (float_cents).floor
end

def process_business_data
    #some sort of scripts that apply intelligence to the data such as .. who is shopping us out
    #comparing quotes to orders... maybe link them up and them loop through the links
    #maybe import customers and acct mgrs using this as well but set a flag 'imported_from_bi' true



     @connection = ActiveRecord::Base.establish_connection('development')


    p 'Assigning best matching companies using fuzzy string match'

    #for every call logger company, set the bi_customer_no ... need to find best match
    Company.all.each do |company|
      ApplicationController.helpers.assignBestMatchingBiCustomerToCompany(company)
    end


    #assign bi_outside_sales_rep_id to users based on matching code - do it on edit too
    User.all.each do |user|
      ApplicationController.helpers.assignBestMatchingBiOutsideSalesRepToUser(user)

    end



    #build the QuoteAnalytic models which basically bundle up all related quotes to an order and show which pieces were shopped out... these are tied to BI Customer no



end

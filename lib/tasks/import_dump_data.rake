
#this runs every night thanks to Cron and Whenever gem!
require 'date'


namespace :db do

  desc 'try to connect'
  task import_and_process_dump_data: :environment do

    wipe_business_data()
    import_business_data()
    process_business_data()



  end
end


def wipe_business_data
  p 'deleting all business data... '
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

      query_date_min = date
      query_date_max = date + 1.day

      query_date_min_formatted = date.strftime("%m/%d/%Y")
      query_date_max_formatted = date.strftime("%m/%d/%Y")

      @connection = ActiveRecord::Base.establish_connection('sqlserver')


        #SQL SERVER Syntax
      sql = "SELECT *
       FROM Open_OrdersVW
       WHERE EnterDate >= '"+query_date_min_formatted+"'
       AND EnterDate <= '"+query_date_max_formatted+"' "


       @result = @connection.connection.select_all(sql);
      # p @result.as_json

       number_of_rows = 0

       @result.each do |row|
         #p row
         # puts row["column_id"].to_s + " " + row["name"].to_s + " " + row["max_length"].to_s

          createBIOrderFromSQLOutput( row )
          number_of_rows+=1
       end

       p "Imported " + number_of_rows.to_s + " rows."

    end

end

def createBIOrderFromSQLOutput(sql_row)
  p 'creating bi order from output '


 @connection = ActiveRecord::Base.establish_connection('development')

  bi_customer = BiCustomer.create(  #make sure no dup
    "no"=> sql_row["CustomerNo"].to_f.floor,
    "name"=> sql_row["CustomerName"]
  )

  bi_vendor = BiVendor.create(  #make sure no dup
    "no"=> sql_row["VendorNo"].to_f.floor,
    "name"=> sql_row["VendorName"]
  )

  bi_outside_sales_rep = BiOutsideSalesRep.create(  #make sure no dup
    "code"=> sql_row["OutsideSlsrep"],
    "name"=> sql_row["OutsideSlsrepName"]
  )

  bi_inside_sales_rep = BiInsideSalesRep.create(  #make sure no dup
    "code"=> sql_row["InsideSlsrep"],
    "name"=> sql_row["InsideSlsrepName"]
  )

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
    "sales_cents"=>stringMoneyToCents(sql_row["Sales"]),
    "bi_customer_no"=> bi_customer.no,
    "customer_po"=> sql_row["CustomerPO"],
    "ship_to_name"=>sql_row["ShipToName"],
    "ship_to_address1"=>sql_row["ShipToAddress1"],
    "ship_to_city"=>sql_row["ShipToCity"],
    "ship_to_state"=>sql_row["ShipToState"],
    "ship_to_name"=>sql_row["ShipToName"],
    "ship_to_name"=>sql_row["ShipToName"],
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
    p 'saved: ' + new_order.to_s

  else
    p 'not able to save: ' + new_order.errors.full_messages.to_s
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

end

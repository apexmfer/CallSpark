
#this runs every night thanks to Cron and Whenever gem!

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
       p @result.as_json

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


  new_order = BiOrder.new(
    "order_number"=>sql_row["OrderNumber"],
    "order_suffix"=>sql_row["OrderSuffix"],
    "line_number"=>sql_row["LineNumber"],
    "ship_prod"=>sql_row["ShipProd"],
    "prod_desc"=>sql_row["ProdDesc"],
    "prod_cost_cents"=>stringMoneyToCents(sql_row["ProdCost"]),
    "price_cents"=>stringMoneyToCents(sql_row["Price"]),
    "sales_cents"=>stringMoneyToCents(sql_row["Sales"]),

  )

      @connection = ActiveRecord::Base.establish_connection('development')

  if(new_order.save)
    p 'saved: ' + new_order.to_s

  else
    p 'not able to save: ' + new_order.errors.full_messages.to_s
  end

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

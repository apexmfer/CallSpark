
#this runs every night thanks to Cron and Whenever gem!

namespace :db do

  desc 'try to connect'
  task import_and_process_dump_data: :environment do

    wipe_business_data()
    import_business_data()
    process_business_data()



  end
end


def wipe_business_data()


end


def import_business_data()

  #use a loop for this .. loop through each day and import a day at a time


  p 'attempting to connect... '

@connection = ActiveRecord::Base.establish_connection({
  :adapter     => "sqlserver",
  :host          => ENV["ms_sql_db_host"],
  :username => ENV["ms_sql_db_user"],
  :password => ENV["ms_sql_db_password"],
  :database => ENV["ms_sql_db_database"]
})

p 'established connection'


query_date_start = '2/1/2017'
query_date_end = '2/2/2017'



#SQL SERVER Syntax
sql = "SELECT TOP 1 * FROM Quote_OrdersVW"

@result = @connection.connection.select_all(sql);
p @result.as_json

@result.each do |row|
  #p row
   puts row["column_id"].to_s + " " + row["name"].to_s + " " + row["max_length"].to_s
end


end

def process_business_data()
    #some sort of scripts that apply intelligence to the data such as .. who is shopping us out
    #comparing quotes to orders... maybe link them up and them loop through the links
    #maybe import customers and acct mgrs using this as well but set a flag 'imported_from_bi' true 

end

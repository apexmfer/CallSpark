

namespace :db do

  desc 'try to connect'
  task connect_to_bi_dump: :environment do



  #  SELECT smrs_orders_consolidatedVW.VendorName, smrs_orders_consolidatedVW.VendorNo, smrs_orders_consolidatedVW.ProdDesc, smrs_orders_consolidatedVW.ShipProd, smrs_orders_consolidatedVW.QuantityShipped, smrs_orders_consolidatedVW.Sales, smrs_orders_consolidatedVW.ExtCommCost, smrs_orders_consolidatedVW.CustomerName, smrs_orders_consolidatedVW.OutsideSlsrepName, smrs_orders_consolidatedVW.ProdCategory
  #  FROM InforBI_Dump.dbo.smrs_orders_consolidatedVW smrs_orders_consolidatedVW
    #WHERE (smrs_orders_consolidatedVW.OEELPrimarySlsCrdtWhse Like ?) AND (smrs_orders_consolidatedVW.InvoiceDate>=? And smrs_orders_consolidatedVW.InvoiceDate<=?)
    #ORDER BY smrs_orders_consolidatedVW.Sales DESC

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

    sql = "SELECT smrs_orders_consolidatedVW.OrderNumber,
    smrs_orders_consolidatedVW.OrderSuffix,
    smrs_orders_consolidatedVW.LineNumber,
    smrs_orders_consolidatedVW.ShipProd,
    smrs_orders_consolidatedVW.EnterDate,
    smrs_orders_consolidatedVW.ShipDate,
    smrs_orders_consolidatedVW.PromiseDate,
    smrs_orders_consolidatedVW.ProdCategory,
    smrs_orders_consolidatedVW.ProdDesc,
    smrs_orders_consolidatedVW.ProdLine,
    smrs_orders_consolidatedVW.VendorNo,
    smrs_orders_consolidatedVW.VendorName,
    smrs_orders_consolidatedVW.Territory,
    smrs_orders_consolidatedVW.Region,


     smrs_orders_consolidatedVW.QuantityShipped,
     smrs_orders_consolidatedVW.Sales,
     smrs_orders_consolidatedVW.ExtCommCost,
     smrs_orders_consolidatedVW.CustomerNo,
     smrs_orders_consolidatedVW.CustomerName,
     smrs_orders_consolidatedVW.InvoiceDate,
     smrs_orders_consolidatedVW.InsideSlsrep,
     smrs_orders_consolidatedVW.InsideSlsrepName,
     smrs_orders_consolidatedVW.OutsideSlsrep,
     smrs_orders_consolidatedVW.OutsideSlsrepName,
     smrs_orders_consolidatedVW.ProdCategory
     FROM smrs_orders_consolidatedVW WHERE InvoiceDate >= '"+query_date_start+"' AND InvoiceDate <= '"+query_date_end+"' ORDER BY smrs_orders_consolidatedVW.Sales DESC"

    #tell me all of the columns on this table
    #sql = "SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('dbo.smrs_orders_consolidatedVW') "

  #   sql = "SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('dbo.inventoryVW') "


    #list all tables
  #sql = "SELECT * from  INFORMATION_SCHEMA.TABLES  ;"

  #SQL SERVER Syntax
    # sql = "SELECT TOP 1 * FROM inventoryVW"

    sql = "SELECT COUNT(OrderNumber) AS numberOfOrders FROM Quote_OrdersVW ; "

    @result = @connection.connection.select_all(sql);
    p @result.as_json

    @result.each do |row|
      #p row
      puts row["column_id"].to_s + " " + row["name"].to_s + " " + row["max_length"].to_s
    end


  end
end

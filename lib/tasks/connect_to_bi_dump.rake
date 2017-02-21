

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


    sql = "SELECT smrs_orders_consolidatedVW.VendorName, smrs_orders_consolidatedVW.VendorNo, smrs_orders_consolidatedVW.ProdDesc, smrs_orders_consolidatedVW.ShipProd, smrs_orders_consolidatedVW.QuantityShipped, smrs_orders_consolidatedVW.Sales, smrs_orders_consolidatedVW.ExtCommCost, smrs_orders_consolidatedVW.CustomerName, smrs_orders_consolidatedVW.OutsideSlsrepName, smrs_orders_consolidatedVW.ProdCategory FROM smrs_orders_consolidatedVW ORDER BY smrs_orders_consolidatedVW.Sales DESC"

    sql = "SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('dbo.smrs_orders_consolidatedVW') "

    @result = @connection.connection.select_all(sql);


    @result.each do |row|
      p "another one "
       puts row
    end


  end
end

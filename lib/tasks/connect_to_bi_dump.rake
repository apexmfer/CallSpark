

namespace :db do

  desc 'try to connect'
  task connect_to_bi_dump: :environment do


    require 'pg'
    conn = PG.connect('odbc://engineering:engineering@InforBI_Dump/InforBI_Dump')
    puts conn.exec("SELECT count(*) FROM users").to_a



  end
end

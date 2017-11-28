
require 'csv'
require 'date'


namespace :db do

  desc 'export results of search'
  task export_search_results: :environment do
	
	p 'running query and export' 

    	query = 'powerflex'
    	results = querySearchResults(query)
	
	exportSearchResultsToCSV(results)    

	p 'finished export'

  end

    




end


def querySearchResults(query)
  callresponses = Call.search(query,size:5000)

	p callresponses.size
  calls = callresponses.map{|response| Call.find_by_id(response.id)  }

	p calls.length
  return calls
end


def exportSearchResultsToCSV(results)
	p 'exporting results' 
	
	CSV.open("datadump/results.csv","w") do |csv|
    		results.each_with_index do |item,index|
      			puts "done #{index}"
      			csv << [item.id, item.text, item.getCompanyName, item.getCustomerName, item.getUser.name, item.getCategoryName, item.created_at]

		end
  	end

end 

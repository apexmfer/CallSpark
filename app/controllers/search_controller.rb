class SearchController < ApplicationController
	skip_before_filter :require_login


	def search

		@query = params[:query]
	if @query.nil?
		@callresponses = []
			@noresults = true
	else

		@noresults = false

		@callresponses = Call.search "*#{params[:query]}*"
		@calls = @callresponses.map{|response| Call.find_by_id(response.id)  }

		#@matching_companies = Company.find(:all, :conditions => ['name LIKE ?', "%#{params['query']}%"])
		#@matching_customers = Customer.find(:all, :conditions => ['name LIKE ?', "%#{params['query']}%"])

#@matching_companies = Company.where("name like ?", "%#{params['query']}%")
	#	@matching_customers = Customer.where("name like ?", "%#{params['query']}%")

		@company_responses = Company.search "*#{params[:query]}*"
		@matching_companies = @company_responses.map{|response| Company.find_by_id(response.id)  }

		@customer_responses = Customer.search "*#{params[:query]}*"
		@matching_customers = @customer_responses.map{|response| Customer.find_by_id(response.id)  }

		if( @matching_customers.size == 0 && @matching_companies.size == 0 && @calls.size == 0 )
				@noresults = true
		end

	end


  end


end

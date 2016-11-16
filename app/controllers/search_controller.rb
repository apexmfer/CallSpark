class SearchController < ApplicationController
	 #before_filter :require_login


	def search
	if params[:query].nil?
		@callresponses = []
	else
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


	end


  end


end

class SearchController < ApplicationController
	 #before_filter :require_login


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


		@project_responses = Project.order(updated_at: :DESC).search("*#{params[:query]}*")
		@projects = @project_responses.map{|response| Project.find_by_id(response.id)  }
		@projects << @matching_customers.map{|item| item.projects }
		@projects << @matching_companies.map{|item| item.projects  }
		 @projects << @matching_companies.map{|item| item.projects_as_secondary  }
		@projects = @projects.flatten.sort_by(&:"#{:updated_at}").reverse.uniq

		@user_responses = User.order(updated_at: :DESC).search("*#{params[:query]}*")
			@users = @user_responses.map{|response| User.find_by_id(response.id)  }

				if( @matching_customers && @matching_customers.size == 0 && @matching_companies && @matching_companies.size == 0	&& @calls &&  @calls.size == 0 && @projects &&  @projects.size == 0 && @users &&  @users.size == 0   )
						@noresults = true
				end

				if( @matching_customers == nil && @matching_companies ==nil && @calls == nil && @projects == nil && @users=nil  )
						@noresults = true
				end




	end


  end


end

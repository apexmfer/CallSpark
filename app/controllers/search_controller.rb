class SearchController < ApplicationController
	skip_before_filter :require_login


	def search
	if params[:query].nil?
		@callresponses = []
	else
		@callresponses = Call.search params[:query]
		@calls = @callresponses.map{|response| Call.find_by_id(response.id)  }
	end
  end


end

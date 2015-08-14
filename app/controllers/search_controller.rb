class SearchController < ApplicationController
	skip_before_filter :require_login


	def search
	if params[:query].nil?
		@calls = []
	else
		@calls = Call.search params[:query]
	end
  end


end

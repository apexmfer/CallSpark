class AdminController < ApplicationController

  before_filter :require_login
  
    def regions
      @newregion = Region.new
    end
end

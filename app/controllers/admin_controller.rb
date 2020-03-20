class AdminController < ApplicationController

  before_action :require_login

    def regions
      @newregion = Region.new
    end
end

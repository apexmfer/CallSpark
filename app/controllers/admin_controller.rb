class AdminController < ApplicationController

    def regions
      @newregion = Region.new
    end
end

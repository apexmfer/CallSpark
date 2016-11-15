class ProjectsController < ApplicationController

    before_action :set_navbar_style

    def set_navbar_style
      @nav_style = "nav-projects"
    end

  def index
  end

  def show
  end

  def new
    @new_project = Project.new
  end
end

class ProjectsController < ApplicationController

    before_action :set_navbar_style

    def set_navbar_style
      @nav_style = "nav-projects"
    end

  def index
  end

  def show
  end

    def create

       @project = Project.new(new_project_params)
       @project.user = current_user
        @project.save!

      @user_who_commented = @current_user
      @comment = Comment.build_from( @project, @user_who_commented.id, "Hey guys this is my comment!"  )


      redirect_to @project

    end

  def new
    @new_project = Project.new
  end


private
def new_project_params
  params.require(:project).permit(:name)
end

end

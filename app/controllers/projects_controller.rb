class ProjectsController < ApplicationController

    before_action :set_navbar_style

    def set_navbar_style
      @nav_style = "nav-projects"
    end

  def index
  end

  def show
    @project = Project.friendly.find(params[:id])
    @customer = @project.customer
    @project_owner = @project.user
  end

    def create

      p params
      #  "utf8"=>"✓", "authenticity_token"=>"tg7aTXx9Bqe3CpeQLLoWQiR/3Hvq6QQJq3o8CI3TD3oFfBoH7jW5GxSRYiTPS241kj93Fv1gM0P70RATPDamgg==", "project"=>{"customer"=>"Bob G", "primary_company"=>"Crystal", "secondary_company"=>"Ffff", "name"=>"test"}, "code"=>"", "phone"=>"12-345-2131", "email"=>"Aaaaa", "text"=>"aaaabbcccc", "_wysihtml5_mode"=>"1", "controller"=>"projects", "action"=>"create"}





       @project = Project.new(new_project_params)
       @project.user = current_user
        @project.save


        text = sentencify(params[:text])
        text = text.gsub(/&Amp;/,"").gsub(/&Nbsp;/,"").gsub(/Amp;/,"").gsub(/Nbsp;/,"")

        @user_who_commented = @current_user
        @comment = Comment.build_from( @project, @user_who_commented.id, text  )


      redirect_to @project

    end

  def new
    @new_project = Project.new
  end


private
def new_project_params
  params.require(:project).permit(:name,:customer_id)
end

end

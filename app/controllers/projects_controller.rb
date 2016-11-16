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
    @product_segments = @project.product_segments

    @comments = @project.root_comments
  end

    def create

      p params
      #  {"utf8"=>"✓", "authenticity_token"=>"tHAN0XTtgkOzWZIKOwgquAuQ/HAlD/N8geqpzlOzmdkHAs2b5qU9/xDCZ77Y+VLPvdBXHTKGxDbRQYXV4lYwIQ==", "project"=>{"customer"=>"Bob G", "customer_id"=>"4", "primary_company"=>"Crystal", "primary_company_id"=>"", "secondary_company"=>"Ffff", "secondary_company_id"=>"1", "name"=>"fadwddwa"}, "phone"=>"12-345-2131", "email"=>"Aaaaa", "text"=>"dawdwdwdadd", "_wysihtml5_mode"=>"1", "controller"=>"projects", "action"=>"create"}

      primary_comp_id = params[:project][:primary_company_id]

       @project = Project.new(new_project_params)
       @project.user = current_user
        @project.save

        if (primary_comp_id == nil or primary_comp_id.size == 0 or primary_comp_id == 0) and @project.customer!=nil
           @project.primary_company = @project.customer.company
           @project.save
        end

        category_tags = params[:toggle_tags_field].split(" ")
        if category_tags.size > 0
          category_tags.each do |category_tag|
            @project.product_segment_list.add(category_tag)

          end
        end

        @project.save


        text = sentencify(params[:text])
        text = text.gsub(/&Amp;/,"").gsub(/&Nbsp;/,"").gsub(/Amp;/,"").gsub(/Nbsp;/,"")

        @user_who_commented = @current_user
        @comment = Comment.build_from( @project, @user_who_commented.id, text  )
        @project.save



      redirect_to @project

    end

  def new
    @new_project = Project.new
  end


private
def new_project_params
  params.require(:project).permit(:name,:customer_id,:primary_company_id,:secondary_company_id)
end

end

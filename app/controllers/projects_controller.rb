class ProjectsController < ApplicationController
   before_action :require_login, except: [:index,:show,:export]
    before_action :set_navbar_style

    def set_navbar_style
      @nav_style = "nav-projects"
    end

  def index

    @sort_by = "updated_at"
    if params[:sort_by]
      @sort_by = params[:sort_by]
      @order_style = "ASC"
    end

    if @sort_by == "updated_at" then   @order_style = "DESC" end

    #@projects = Project.order(  @sort_by => @order_style ).paginate(:page => params[:page], :per_page => 10)
    @projects = Project.order(  @sort_by => @order_style ).page(params[:page]).per(10)


  end


  def export

    @projects = Project.all


    respond_to do |format|
     format.html
        format.csv { render text: @projects.to_csv }
   end

  end

  def show
    @project = Project.friendly.find(params[:id])
    @customer = @project.customer
    @project_owner = @project.user
    @product_segments = @project.product_segments

    @assignments = @project.assigned_users

    @comments = @project.root_comments.order(updated_at: :DESC ).page(params[:comment_page]).per(10)
  end

    def create

      p params
      #  {"utf8"=>"✓", "authenticity_token"=>"tHAN0XTtgkOzWZIKOwgquAuQ/HAlD/N8geqpzlOzmdkHAs2b5qU9/xDCZ77Y+VLPvdBXHTKGxDbRQYXV4lYwIQ==", "project"=>{"customer"=>"Bob G", "customer_id"=>"4", "primary_company"=>"Crystal", "primary_company_id"=>"", "secondary_company"=>"Ffff", "secondary_company_id"=>"1", "name"=>"fadwddwa"}, "phone"=>"12-345-2131", "email"=>"Aaaaa", "text"=>"dawdwdwdadd", "_wysihtml5_mode"=>"1", "controller"=>"projects", "action"=>"create"}

      primary_comp_id = params[:project][:primary_company_id]

       @project = Project.new(new_project_params)
       @project.user = current_user
        @project.save

        @customer = spawnCustomer(params[:project][:customer],params[:project][:primary_company],params[:phone],params[:email],nil,nil)

          @project.customer = @customer

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

        @project.save!


          assignment = ProjectAssignment.create(project: @project, user: @current_user)

        text = sentencify(params[:text])
        text = text.gsub(/&Amp;/,"").gsub(/&Nbsp;/,"").gsub(/Amp;/,"").gsub(/Nbsp;/,"")

        @user_who_commented = @current_user
        @comment = Comment.build_from( @project, @user_who_commented.id, text  )
        @comment.save



      redirect_to @project

    end

  def new
    @new_project = Project.new
  end


  def edit
      @project = Project.friendly.find(params[:id])

          @assignments = @project.assigned_users
  end


  def update
    p params
      @project = Project.friendly.find(params[:id])

      @project.update_attributes!(edit_project_params)


      datetime_format = "%m/%d/%Y"
      if params[:project][:data_received_date] and params[:project][:data_received_date].length > 0
      @project.data_received_date = DateTime.strptime(params[:project][:data_received_date], datetime_format)   #unix time
      end
      if params[:project][:sized_date] and params[:project][:sized_date].length > 0
      @project.sized_date = DateTime.strptime(params[:project][:sized_date], datetime_format)   #unix time
      end
      if params[:project][:proposal_date] and params[:project][:proposal_date].length > 0
      @project.proposal_date = DateTime.strptime(params[:project][:proposal_date], datetime_format)   #unix time
      end
      if params[:project][:follow_up_date] and params[:project][:follow_up_date].length > 0
      @project.follow_up_date = DateTime.strptime(params[:project][:follow_up_date], datetime_format)   #unix time
      end


      #find or create customer
      customer_name = params["project"]["customer_name"]
      customer = Customer.find_or_create_by(name: customer_name)
      @project.customer = customer

      #find or create primary company
      primary_company_name = format_as_company_name(params["project"]["primary_company_name"])
      primary_company = Company.find_or_create_by(name: primary_company_name)
      @project.primary_company = primary_company

      secondary_company_name = format_as_company_name(params["project"]["secondary_company_name"])
      secondary_company = Company.find_or_create_by(name: secondary_company_name)
      @project.secondary_company = secondary_company


      @project.save!

      redirect_to @project

  end

  def destroy
      @project = Project.friendly.find(params[:id])
      @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end


private
def new_project_params
  params.require(:project).permit(:name,:customer_id,:primary_company_id,:secondary_company_id,:cost_estimate)
end


def edit_project_params
  params.require(:project).permit(:name,:cost_estimate,:customer_id,:primary_company_id,:secondary_company_id,:data_received_date,:sized_date,:proposal_date,:follow_up_date)
end


end

class ProjectAssignmentController < ApplicationController

  def create
    @project = Project.find_by_id(params[:project_id])
    @user = User.find_by_id(params[:user_id])

    assignment = ProjectAssignment.create!(project: @project, user: @user)
    render json: assignment
  end

  def destroy
    @project = Project.find_by_id(params[:project_id])
    @user = User.find_by_id(params[:user_id])

    assignment = ProjectAssignment.where(project_id: @project.id, user_id: @user.id).first
    assignment.destroy
      render json:  @project
  end

end

class DeveloperProjectsController < ApplicationController
  def index
    user = User.find(current_user.id)
    @projects = user.projects.paginate(page: params[:page], per_page: 5)
  end
  def show
    @project = Project.friendly.find(params[:id])
  end
  def solved
    @bug = Bug.friendly.find(params[:id])
    flash[:notice] = @bug
    @project = Project.find(@bug.project_id)
    redirect_to developer_project_path
  end
end
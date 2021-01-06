class DeveloperProjectsController < ApplicationController
  def index
    user = User.find(current_user.id)
    @projects = user.projects.paginate(page: params[:page], per_page: 5)
  end
  def show
    @project = Project.friendly.find(params[:id])
  end
end
class QaProjectsController < ApplicationController
  def index
    @projects = Project.paginate(page: params[:page], per_page: 5)
    authorize @projects
  end
  def show
    @project = Project.friendly.find(params[:id])
    authorize @project
  end
end
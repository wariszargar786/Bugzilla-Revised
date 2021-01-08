class QaProjectsController < ApplicationController
  def index
    authorize! :index, QaProjectsController
    @projects = Project.paginate(page: params[:page], per_page: 5)
  end
  def show
    authorize! :show, QaProjectsController
    @project = Project.friendly.find(params[:id])
  end
end
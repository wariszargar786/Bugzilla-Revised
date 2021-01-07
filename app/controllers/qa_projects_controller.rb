class QaProjectsController < ApplicationController
  def index
    @projects = Project.paginate(page: params[:page], per_page: 5)
  end
  def show
    @project = Project.friendly.find(params[:id])
  end
end
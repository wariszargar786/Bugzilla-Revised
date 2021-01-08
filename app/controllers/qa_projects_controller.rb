class QaProjectsController < ApplicationController

  def show
    authorize! :show, QaProjectsController
    @project = Project.friendly.find(params[:id])
  end
end
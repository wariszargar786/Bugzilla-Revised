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
    if @bug.bug_type == "#{Bug.bug_type_list.keys[0]}"
      @bug[:status] = Bug.bug_status_list.keys[3]
    else
      @bug[:status] = Bug.bug_status_list.keys[2]
    end
    @bug.save
    @project = Project.find(@bug.project_id)
    flash[:notice] = "Mark as #{@bug.status}"
    redirect_to developer_project_show_path(@bug.project_id)
  end
end
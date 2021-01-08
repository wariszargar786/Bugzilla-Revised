class DeveloperProjectsController < ApplicationController
  def index
    user = User.find(current_user.id)
    @projects = user.projects.paginate(page: params[:page], per_page: 5)
    authorize! :index, DeveloperProjectsController
  end

  def show
    authorize! :show, DeveloperProjectsController
    @project = Project.friendly.find(params[:id])
  end

  def solved
    authorize! :solved, DeveloperProjectsController
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

  def assign_himself
    authorize! :assign_himself, DeveloperProjectsController
    @bug = Bug.friendly.find(params[:id])
  end

  def assign_himself_post
    authorize! :assign_himself_post, DeveloperProjectsController
    bug_users = BugUser.new(params.require(:anything).permit(:deadline))
    bug = Bug.friendly.find(params[:id])
    bug_users[:bug_id] = bug.id
    bug_users[:user_id] = current_user.id
    bug_users.save
    flash[:notice] = "Bug assign to himself successfully"
    redirect_to developer_project_show_path(bug.project_id)
  end
end
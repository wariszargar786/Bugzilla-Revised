class DeveloperProjectsController < ApplicationController
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
    redirect_to project_path(@bug.project_id)
  end
  def assign_himself
    authorize! :assign_himself, DeveloperProjectsController
    @bug = Bug.friendly.find(params[:id])
    @bug_user = BugUser.new
  end
  def assign_himself_post
    session[:notice] = nil
    authorize! :assign_himself_post, DeveloperProjectsController
    @bug_users = BugUser.new(params.require(:bug_user).permit(:deadline))
    @bug = Bug.friendly.find(params[:id])
    @bug_users[:bug_id] = @bug.id
    @bug_users[:user_id] = current_user.id
    if @bug_users.save
    flash[:notice] = "Bug assign to himself successfully"
    redirect_to project_path(@bug.project_id)
    else
      session[:notice] = "Please provide date"
      render 'assign_himself'
    end
  end
end
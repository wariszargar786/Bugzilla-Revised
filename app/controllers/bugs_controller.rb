class BugsController < ApplicationController
  def new
    @bug = Bug.new
  end
  def create
    @bug = Bug.new(bug_params)
    project = Project.friendly.find(params[:id])
    @bug[:user_id] = current_user.id
    @bug[:project_id] =project.id
    if @bug.save
      flash[:notice] = 'Bug successfully created'
      redirect_to qa_project_show_path(project)
    else
      render 'new'
    end
  end
  def edit
    @bug = Bug.friendly.find(params[:id])
  end
  def update
    @bug = Bug.friendly.find(params[:id])
    if @bug.update(bug_params)
      flash[:notice] = "Bug updated successfully"
      redirect_to qa_project_show_path(@bug.project_id)
    else
      render 'edit'
    end
  end
  def assign_developer
    @bug =  Bug.friendly.find(params[:id])
    @users = @bug.project.users.where(role:User.user_role.keys[0])
  end
  def assign_developer_to_bug
    message = "Bug successfully assign to user"
    bug_users = BugUser.new(params.require(:anything).permit(:user_id,:deadline))
    bug = Bug.friendly.find(params[:id])
    user = User.find(bug_users[:user_id])
    if bug.bug_users.where.not(id: bug_users[:user_id]).count <= 0 && bug.bug_users.count <= 0
      bug_users[:bug_id] = bug.id
      bug_users.save
    else
      message = "Bug already assign"
    end
    flash[:notice] = message
    redirect_to qa_project_show_path(bug.project_id)

  end

  private
  def bug_params
    params.require(:bug).permit(:title , :description,:bug_type , :status ,:image)
  end
end

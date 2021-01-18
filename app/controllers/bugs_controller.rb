class BugsController < ApplicationController
  def new
    authorize! :new, BugsController
    @bug = Bug.new
  end

  def create
    @bug = Bug.new(bug_params)
    @project = Project.friendly.find(params[:id])
    @bug[:user_id] = current_user.id
    @bug[:project_id] = @project.id
    authorize! :create, BugsController
    if @bug[:status] == "#{Bug.bug_status_list.keys[2]}" || @bug[:status] == "#{Bug.bug_status_list.keys[3]}"
      @bug[:completed_at] = DateTime.now
    end
    if @bug.save
      flash[:notice] = 'Bug successfully created'
      redirect_to project_path(@project)
    else
      render 'new'
    end
  end

  def edit
    authorize! :edit, BugsController
    @bug = Bug.friendly.find(params[:id])
  end

  def update
    authorize! :update, BugsController
    @bug = Bug.friendly.find(params[:id])
    status = ""
    if @bug[:status] == "#{Bug.bug_status_list.keys[2]}" || @bug[:status] == "#{Bug.bug_status_list.keys[3]}"
      status ="*-*-*-- if *-*-*-*"
      @bug[:completed_at] = DateTime.now
    else
      status ="*-*-*-- else *-*-*-*"
      @bug[:completed_at] = nil?
    end
    if @bug.update(bug_params)
      flash[:notice] = "Bug updated successfully #{status}"
      redirect_to project_path(@bug.project_id)
    else
      render 'edit'
    end
  end
  def assign_developer
    @bug_user = BugUser.new
    authorize! :assign_developer, BugsController
    @bug = Bug.friendly.find(params[:id])
    @users = @bug.project.users.where(role: User.user_role.keys[0])
  end
  def reassign_developer
    authorize! :reassign_developer, BugsController
    @bug = Bug.friendly.find(params[:id])
    @bug_user = BugUser.new
    @users = @bug.project.users.where(role: User.user_role.keys[0])
  end


  def assign_developer_to_bug
    authorize! :assign_developer_to_bug, BugsController
    message = "Bug successfully assign to user"
    @bug_users = BugUser.new(bu_user_params)
    @bug = Bug.friendly.find(params[:id])
    @users = @bug.project.users.where(role: User.user_role.keys[0])
    if @bug.bug_users.where.not(id: @bug_users[:user_id]).count <= 0 && @bug.bug_users.count <= 0
      @bug_users[:bug_id] = @bug.id
    else
      message = "Bug already assign"
    end
    if @bug_users.save
      flash[:notice] = message
      redirect_to project_path(@bug.project_id)
    else
      flash[:alert] =  "Please provide both user & date time"
      render 'assign_developer'
    end
  end

  def reassign_developer_to_bug
    authorize! :reassign_developer_to_bug, BugsController
    message = "Bug successfully assign to user"
    @bug_users = BugUser.new(bu_user_params)
    @bug = Bug.friendly.find(params[:id])
    @users = @bug.project.users.where(role: User.user_role.keys[0])
    if @bug.bug_users.where.not(id: @bug_users[:user_id]).count <= 0 && @bug.bug_users.count <= 0
      @bug_users[:bug_id] = @bug.id
    else
      message = "Bug already assign"
    end
    if @bug_users.save
      flash[:notice] = message
      redirect_to project_path(@bug.project_id)
    else
      flash[:alert] =  "Please provide both user & date time"
      render 'assign_developer'
    end
  end
  private

  def bug_params
    params.require(:bug).permit(:title, :description, :bug_type, :status, :image)
  end
  def bu_user_params
    params.require(:bug_user).permit(:user_id, :deadline)
  end
end

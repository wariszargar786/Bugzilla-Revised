class ProjectsController < ApplicationController
  def index
    user = User.find(current_user.id)
    @projects = user.projects.paginate(page: params[:page], per_page: 5)
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project['user_id'] = current_user.id
    if @project.save
      flash[:notice] = "Project created successfully"
      redirect_to projects_path
    else
      render 'new'
    end
  end

  def show
    @project = Project.friendly.find(params[:id])
    @users = @project.users.all
  end

  def edit
    @project = Project.friendly.find(params[:id])
  end

  def update
    @project = Project.friendly.find(params[:id])
    if @project.update(project_params)
      redirect_to projects_path, notice: 'Project successfully updated.'
    else
      render 'edit'
    end
  end

  def add_user
    @project_id = params[:id]
    @users = User.where(role: [User.user_role.keys[0], User.user_role.keys[1]])
  end

  def add_user_post
    anything = params.require(:anything).permit(:user_id, :project_id)
    project = Project.friendly.find(anything['project_id'])
    user = User.find(anything['user_id'])
    message = "This User #{user.name} already link to this project"
    if user.projects.count <= 0
      user.projects << project
      message = "User #{user.name} assign to project"
    end
    flash[:notice] = message
    redirect_to projects_path
  end

  def destroy
    project = Project.friendly.find(params[:id])
    project.users.clear
    project.destroy
    redirect_to projects_path, notice: 'Project deleted successfully'
  end

  def delete_user_project
    user_id = params[:id]
    user = User.find(user_id)
    user.projects.clear
    redirect_to projects_path, notice: 'User remove successfully ' + user_id
  end

  private

  def project_params
    params.require(:project).permit(:title, :description)
  end
end

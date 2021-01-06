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
    if @project.save
      user = User.find(current_user.id)
      user.projects << @project
      flash[:notice] = "Project created successfully"
      redirect_to projects_path
    else
      render 'new'
    end
  end

  def show
    @project = Project.friendly.find(params[:id])
    @users = @project.users.where.not(id:  current_user.id).paginate(page: params[:page], per_page: 5)
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
    @users = User.where(role: [User.user_role.keys[0], User.user_role.keys[2]])
  end

  def add_user_post
    anything = params.require(:anything).permit(:user_id, :project_id)
    project = Project.friendly.find(anything['project_id'])
    user = User.friendly.find(anything['user_id'])
    message = "This user #{user.name} already link with this project"
    if  project.users.where(id:user).count <=0
      user.projects << project
      message = "This user #{user.name} link with this project"
    end
    flash[:notice] = message
    redirect_to project_path(project)
  end

  def destroy
    project = Project.friendly.find(params[:id])
    project.users.clear
    project.destroy
    redirect_to projects_path, notice: 'Project deleted successfully'
  end

  def delete_user_project
    user = User.friendly.find(params[:uid])
    project = Project.friendly.find(params[:pid])
    user.projects.destroy(project)
    flash[:notice] = "This user remove from the project"
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:title, :description)
  end
end

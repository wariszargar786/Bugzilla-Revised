class ProjectsController < ApplicationController
  def index
    @user = User.find(current_user.id)
    @projects = @user.projects.paginate(page: params[:page], per_page: 5)
    authorize! :index, ProjectsController
  end
  def new
    @project = Project.new
    authorize! :new, ProjectsController
  end
  def create
    authorize! :create, ProjectsController
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
    authorize! :show, ProjectsController
    @project = Project.friendly.find(params[:id])
    @users = @project.users.where.not(id: current_user.id).paginate(page: params[:page], per_page: 5)
  end

  def edit
    authorize! :edit, ProjectsController
    @project = Project.friendly.find(params[:id])
  end

  def update
    authorize! :update, ProjectsController
    @project = Project.friendly.find(params[:id])
    if @project.update(project_params)
      redirect_to projects_path, notice: 'Project successfully updated.'
    else
      render 'edit'
    end
  end

  def add_user
    authorize! :add_user, ProjectsController
    @project_id = params[:id]
    @users = User.where(role: [User.user_role.keys[0], User.user_role.keys[2]])
  end

  def get_user_lists
    users = User.where(role: params[:id])
    render json: users
  end
  def add_user_post
    authorize! :add_user_post, ProjectsController
    anything = params.require(:anything).permit(:user_id)
    if anything[:user_id] == "" || params[:id] == ""
      flash[:alert] = "Please select user first"
      render 'add_user'
    else
      project = Project.friendly.find(params[:id])
      user = User.find(anything['user_id'])
      message = "This user #{user.name} already link with this project"
      if project.users.where(id: user).count <= 0
        user.projects << project
        message = "This user #{user.name} link with this project"
      end
      flash[:notice] = message
      redirect_to project_path(project)
    end

  end

  def destroy
    authorize! :destroy, ProjectsController
    project = Project.friendly.find(params[:id])
    project.bugs.each do |bug|
      bug.bug_users.destroy_all
    end
    project.bugs.destroy_all
    project.users.destroy_all
    project.destroy
    redirect_to projects_path, notice: 'Project deleted successfully'
  end

  def delete_user_project
    authorize! :delete_user_project, ProjectsController
    user = User.friendly.find(params[:uid])
    project = Project.friendly.find(params[:pid])
    user.projects.destroy(project)
    flash[:notice] = "This user remove from the project"
    redirect_to projects_path
  end

  def show_list_of_bugs
    @user = User.find(current_user.id)
    @projects = @user.projects
  end

  private

  def project_params
    params.require(:project).permit(:title, :description)
  end
end

class ProjectsController < ApplicationController
  def index
    user  = User.find(current_user.id)
    @projects = user.projects
  end
  def new
    @project = Project.new
  end
  def create
    @project = Project.new(project_params)
    @project['user_id'] = current_user.id
    if @project.save
      flash[:notice]  = "Project created successfully"
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
    authorize @project
  end
  def update
    project = Project.friendly.find(params[:id])
    if project = project.update(params.require(:project).permit(:title , :description))
      redirect_to projects_path, notice: 'Project is successfully updated.'
    else
      render 'edit'
    end
  end


  def add_user
    @project_id = params[:id]
    @users = User.where(role: ['qa','developer'])
  end
  def add_user_post
    message =  'User assign to project '
    anything = params.require(:anything).permit(:user_id,:project_id)
    if anything
      project = Project.friendly.find(anything['project_id'])
      user = User.find(anything['user_id'])
      status = project.users.exists?
      if status==false
        project.users << user
        message= 'This user already link to this project'
      end
      redirect_to projects_path, notice: message
    else
      render :new
    end
  end
  def destroy
    project = Project.friendly.find(params[:id])
    project.users.clear
    project.destroy
    redirect_to projects_path, notice: 'Project deleted successfully'
  end
  def delete_user_project
    user_id =  params[:id]
    user = User.find(user_id)
    user.projects.clear
    redirect_to projects_path, notice: 'User remove successfully ' + user_id
  end


  private
  def project_params
    params.require(:project).permit(:title , :description)
  end
end

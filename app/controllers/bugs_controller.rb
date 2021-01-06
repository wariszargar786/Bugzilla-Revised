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

  private
  def bug_params
    params.require(:bug).permit(:title , :description,:bug_type , :status ,:image)
  end
end
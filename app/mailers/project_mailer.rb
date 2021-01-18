class ProjectMailer < ApplicationMailer
  def create_project(project,user)
    @project = project
    @current_user = user
    mail(to: @current_user.email, subject: "Project created with title #{project.title}")
  end
end

class SchedualesController < ApplicationController
  def send_email
    users = User.where(role: User.roles.keys[1])
    users.each do |user|
      projects = user.projects
      projects.each do |project|
         ScheduleMailer.send_mail(user, project).deliver
      end
    end
  end
end

class SchedualesController < ApplicationController
  def send_email
    users = User.where(role: User.roles.keys[1])
    users.each do |user|
      projects = user.projects
      ScheduleMailer.send_mail(user, projects).deliver
    end
  end
end

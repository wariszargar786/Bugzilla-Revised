class ScheduleMailer < ApplicationMailer
  def send_mail(user, projects)
    @project_report = []
    projects.each do |project|
      project_title = project.title
      total_no_of_bugs = project.bugs.count
      total_no_of_bugs_created_today = project.bugs.created_between(1.day.ago, Time.now).count
      total_no_of_bugs_completed_today = project.bugs.completed_between(1.day.ago, Time.now).count
      no_of_devs = 0
      no_of_qa = 0
      project.project_users.each do |project_user|
        role = project_user.user.role
        if role == "#{User.user_role.keys[0]}"
          no_of_devs += 1
        elsif role == "#{User.user_role.keys[2]}"
          no_of_qa += 1
        end
      end
      single_project = {
        "project_title" => project_title ,
        "total_no_of_bugs" => total_no_of_bugs,
        "total_no_of_bugs_created_today" => total_no_of_bugs_created_today,
        "no_of_devs"=> no_of_devs,
        "no_of_qa" => no_of_qa,
        'total_no_of_bugs_completed_today'=> total_no_of_bugs_completed_today
      }
      @project_report.push(single_project)
    end
    mail to: user.email, subject: "Today Report"
  end
end

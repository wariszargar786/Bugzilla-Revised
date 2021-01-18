class CreateProjectJob < ApplicationJob
  queue_as :default
  def perform(*args)
    user = User.first
    project = Project.new
    project.title  = Faker::Book.title
    project.description  = Faker::Book.author
    project.save!
    user.projects << project
    puts "Project Save "
  end
end

# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
User.create!([{ name: 'Developer', password:"password", email:"developer@gmail.com", role:1 }, { name: 'Manager', password:"password", email:"manager@gmail.com", role:2 },{ name: 'Quality Assurance', password:"password", email:"qa@gmail.com", role:3 }])
# 15.times do |i|
#   Project.create!(title: "Project ##{i}", description: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.")
# end
# @projects = Project.all
# @projects.each do |project|
#   user = User.find(2)
#   user.projects << project
# end
# #   Character.create(name: 'Luke', movie: movies.first)
#

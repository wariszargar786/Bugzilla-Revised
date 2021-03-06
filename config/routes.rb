Rails.application.routes.draw do
  # Rails.application.routes.default_url_options[:host] = "http://127.0.0.1:3000"
  get 'schedual', to: 'scheduales#send_email'

  Rails.application.routes.default_url_options[:host] = "https://bugzillaproject.herokuapp.com"
  # root route or landing page or home page
  root :to => redirect("/login")
  # routes for login registration edit account logout etc
  devise_for :users,path: '', path_names: { sign_in: 'login', sign_out: 'logout' , sign_up: 'register' }
  # routes for Manager role
  resources :projects
  get 'project/:id/assign', to: 'projects#add_user', as: "add_user"
  post 'project/:id/assign', to: 'projects#add_user_post', as: "add_user_post"
  delete 'delete_user_project/:uid/:pid', to: 'projects#delete_user_project', as: "delete_user_project"
  get 'bugs/list', to: 'projects#show_list_of_bugs', as: "show_list_of_bugs"
  get 'user/list/:id', to: 'projects#get_user_lists', as:'get_user_lists'
  # routes for QA role
  get 'bug/:id/new', to:'bugs#new', as:"bug_new"
  post 'bug/:id/new', to:'bugs#create', as:"bugs"
  get 'bug/:id/edit', to:'bugs#edit', as:"bug_edit"
  patch 'bug/:id/edit', to:'bugs#update', as:"bug_update"
  get 'bug/:id/assign/', to: 'bugs#assign_developer', as:"assign_developer"
  get 'bug/:id/reassign/', to: 'bugs#reassign_developer', as:"re_assign_developer"
  post 'bug/:id/assign', to: 'bugs#assign_developer_to_bug', as:"assign_developer_post"
  post 'bug/:id/reassign', to: 'bugs#reassign_developer_to_bug', as:"reassign_developer_post"
  # routes for Developer role
  get 'show/:id/project', to: "developer_projects#show", as:"developer_project_show"
  get 'bug/:id/solved', to:"developer_projects#solved", as: "bug_solved"
  get 'bug/:id/assignhimself/', to: 'developer_projects#assign_himself', as:"assign_himself"
  post 'bug/:id/assignhimself/', to: 'developer_projects#assign_himself_post', as:"assign_himself_post"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  # root route or landing page or home page
  root 'pages#home'

  # routes for login registration edit account logout etc
  devise_for :users,path: '', path_names: { sign_in: 'login', sign_out: 'logout' , sign_up: 'register' }

  # Routes redirect after login
  get "dashboard", to:'dashboard#index',as: 'dashboard'

  # general routes for pages controller
  get 'about' ,to: 'pages#about', as:'about'
  get 'contact' ,to: 'pages#contact', as:'contact'

  # routes for Manager role
  resources :projects
  get 'project/:id/assign', to: 'projects#add_user', as: "add_user"
  post 'project/:id/assign', to: 'projects#add_user_post', as: "add_user_post"
  delete 'delete_user_project/:uid/:pid', to: 'projects#delete_user_project', as: "delete_user_project"


  # routes for QA role
  get 'list/projects', to: "qa_projects#index", as:"qa_project"
  get 'show/:id/projects', to: "qa_projects#show", as:"qa_project_show"

  # routes for Developer role

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

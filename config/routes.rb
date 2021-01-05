Rails.application.routes.draw do
  get "dashboard", to:'dashboard#index',as: 'dashboard'
  devise_for :users,path: '', path_names: { sign_in: 'login', sign_out: 'logout' , sign_up: 'register' }
  root 'pages#home'
  get 'about' ,to: 'pages#about', as:'about'
  get 'contact' ,to: 'pages#contact', as:'contact'
  resources :projects
  get 'project/:id/assign', to: 'projects#add_user', as: "add_user"
  post 'project/:id/assign', to: 'projects#add_user_post', as: "add_user_post"


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  resources :posts
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout' }

  get 'welcome/index'

  root 'welcome#index'
end

Rails.application.routes.draw do
  resources :sections
  resources :users
  resources :projects

  get 'projects/index'

  root 'users#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  
  resources :students
  resources :users

  resources :sections do
    resources :projects
  end

  root 'users#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

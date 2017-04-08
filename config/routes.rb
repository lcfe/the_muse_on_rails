Rails.application.routes.draw do
  resources :jobs, only: [:index]
  post '/jobs', to: 'jobs#index'

  root 'jobs#index'
end

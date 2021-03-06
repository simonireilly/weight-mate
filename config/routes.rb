Rails.application.routes.draw do
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'users#home'

  resources :data
  get '/intensity', to: 'users#intensity'
  get '/records', to: 'users#records'
  get '/maximum', to: 'users#maximum'
end

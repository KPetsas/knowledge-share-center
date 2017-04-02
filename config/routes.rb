Rails.application.routes.draw do
  root "pages#home"
  get 'pages/home', to: 'pages#home'

  resources :guides

  get '/signup', to: 'experts#new'
  resources :experts, except: [:new]
end

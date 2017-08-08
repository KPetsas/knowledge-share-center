Rails.application.routes.draw do
  root "pages#home"
  get 'pages/home', to: 'pages#home'

  resources :guides do
    resources :comments, only: [:create]
  end

  get '/signup', to: 'experts#new'
  resources :experts, except: [:new]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :topics, except: [:destroy]

  mount ActionCable.server => '/cable'
end

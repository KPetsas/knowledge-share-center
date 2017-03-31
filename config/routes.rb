Rails.application.routes.draw do
  root "pages#home"
  get 'pages/home', to: 'pages#home'

  get '/guides', to: 'guides#index'
  get '/guides/:id', to: 'guides#show', as: 'guide'
end

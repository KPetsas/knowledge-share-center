Rails.application.routes.draw do
  root "pages#home"
  get 'pages/home', to: 'pages#home'

  get '/guides', to: 'guides#index'
end

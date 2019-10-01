Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # root
  root to: 'home#index'

  # for the health check
  get '/monitor', to: 'monitor#ping'
end

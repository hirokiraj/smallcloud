Rails.application.routes.draw do
  devise_for :users
  root 'static#index'

  get '/not_secured', to: 'test#not_secured'
  get '/secured', to: 'test#secured'
end

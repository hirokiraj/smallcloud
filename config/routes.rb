Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations", :sessions => "sessions"}
  root 'static#index'

  get '/secured', to: 'test#secured'
end

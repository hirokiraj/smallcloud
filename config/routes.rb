Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations", :sessions => "sessions"}
  root 'static#index'

  get '/secured', to: 'test#secured'

  resources :directories, only: [:index, :show, :create, :destroy], defaults: { format: 'json' }
  get '/directories/parent/:id', to: 'directories#parent', as: :directory_parent
  get '/directories/children/:id', to: 'directories#children', as: :directory_children
end

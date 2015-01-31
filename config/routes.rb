Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations", :sessions => "sessions"}
  root 'static#index'

  get '/secured', to: 'test#secured'

  resources :directories, only: [:index, :show, :create, :destroy], defaults: { format: 'json' }
  get '/directories/parent/:id', to: 'directories#parent', as: :directory_parent
  get '/directories/children/:id', to: 'directories#children', as: :directory_children

  resources :file_entities, only: [:index, :show, :create, :destroy], defaults: { format: 'json' }
  get '/file_entities/parent/:id', to: 'file_entities#parent', as: :file_entity_parent

  get '/search/:search_term', to: 'search#search', as: :search

  get '/quota', to: 'quota#quota', as: :quota
end

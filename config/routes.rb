Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  root 'home#index'

  resources :sources, only: [:show]
  resources :commentaries, only: [:show]
  resources :authors, only: [:index, :show]
  resources :topics, only: [:index]
  resources :regions, only: [:index]
  resources :document_types, path: '/document-types', only: [:index]
  resources :collaborators, only: [:index, :show]
  resources :users, only: [:index, :update]
  resource :search, only: [:show]
end

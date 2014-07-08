Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  root 'home#index'

  resources :sources, only: [:show]
  resources :commentaries, only: [:show]
  resources :authors, only: [:index, :show]
  resources :regions, only: [:index]
  resources :document_types, path: '/document-types', only: [:index]
  resources :collaborators, only: [:index, :show]
  resources :users, only: [:show]
  resource :search, only: [:show]

  namespace :admin do
    resources :users, only: [:index, :update]
    resources :collaborators, only: [:index, :new, :edit, :create, :update]
    resources :topics, only: [:index, :new, :edit, :create, :update, :destroy]
  end
end

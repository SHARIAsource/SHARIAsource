Rails.application.routes.draw do
  devise_for :users,
    controllers: { registrations: 'registrations' },
    path_names: { sign_in: 'login', sign_up: 'signup', sign_out: 'logout' }

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
    resources :themes, only: [:index, :new, :edit, :create, :update, :destroy]
    resources :document_types, path: '/document-types', only: [
      :index, :new, :edit, :create, :update, :destroy
    ]
    resources :regions, only: [:index, :new, :edit, :create, :update, :destroy]
    resources :tags, only: [:index, :new, :edit, :create, :update, :destroy]
  end
end

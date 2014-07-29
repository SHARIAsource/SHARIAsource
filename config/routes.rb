Rails.application.routes.draw do
  require 'sidekiq/web'

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
    resources :users, only: [:index, :edit, :update]
    resources :collaborators, only: [
      :index, :new, :edit, :create, :update, :destroy
    ]
    resources :topics, only: [:index, :new, :edit, :create, :update, :destroy]
    resources :themes, only: [:index, :new, :edit, :create, :update, :destroy]
    resources :document_types, path: '/document-types', only: [
      :index, :new, :edit, :create, :update, :destroy
    ]
    resources :regions, only: [:index, :new, :edit, :create, :update, :destroy]
    resources :tags, only: [:index, :new, :edit, :create, :update, :destroy]
    resources :eras, only: [:index, :new, :edit, :create, :update, :destroy]
    resources :statics, only: [:index, :new, :edit, :create, :update, :destroy]
    resources :sources, only: [:index, :new, :edit, :create, :update, :destroy]
  end

  authenticate :user, lambda {|u| u.is_admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  get '*slug', controller: 'statics', action: 'show'
end

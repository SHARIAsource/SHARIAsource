Rails.application.routes.draw do
  require 'sidekiq/web'

  devise_for :users,
    controllers: { registrations: 'registrations', sessions: 'sessions' },
    path_names: { sign_in: 'login', sign_up: 'signup', sign_out: 'logout' }

  root 'home#index'

  resource :search, only: [:show]
  resources :documents, only: [:show] do
    resources :tag_suggestions, path: '/tag-suggestions', only: [:create]
  end
  resources :authors, only: [:index, :show]
  resources :regions, only: [:index]
  resources :document_types, path: '/document-types', only: [:index]
  resources :collaborators, only: [:index, :show]
  resources :topics, only: [:index]
  resources :eras, only: [:index]
  resources :users, only: [:show]

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
    resources :reference_types, path: '/reference-types', only: [
      :index, :new, :edit, :create, :update, :destroy
    ]
    resources :languages, only: [
      :index, :new, :edit, :create, :update, :destroy
    ]
    resources :regions, only: [:index, :new, :edit, :create, :update, :destroy]
    resources :tags, only: [:index, :new, :edit, :create, :update, :destroy]
    resources :eras, only: [:index, :new, :edit, :create, :update, :destroy]
    resources :statics, only: [:index, :new, :edit, :create, :update, :destroy]
    resources :documents, only: [
      :index, :new, :edit, :create, :update, :destroy
    ]
  end

  authenticate :user, lambda {|u| u.is_admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  get '*slug', controller: 'statics', action: 'show'
end

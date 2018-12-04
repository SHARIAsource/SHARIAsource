Rails.application.routes.draw do
  mount Maily::Engine, at: '/maily'
  require 'sidekiq/web'

  devise_for :users,
    controllers: { registrations: 'registrations', sessions: 'sessions' },
    path_names: { sign_in: 'login', sign_up: 'signup', sign_out: 'logout' }

  root 'home#index'

  resource :search, only: [:show]
  resources :documents, only: [:index, :show] do
    resources :tag_suggestions, path: '/tag-suggestions', only: [:create]
    post :secure_content
    get :secure_content
    get :download
  end
  resources :contributors, only: [:index, :show]
  resources :regions, only: [:index]
  resources :document_types, path: '/document-types', only: [:index]
  resources :collaborators, only: [:index, :show]
  resources :projects, only: [:show] do
    get ':named_filter_id' => 'projects#search', as: :search, on: :member
  end
  resources :topics, only: [:index]
  resources :eras, only: [:index]
  resources :users, only: [:show, :update, :index]

  namespace :admin do
    resources :users, only: [:index, :new, :edit, :create, :update, :destroy]
    resources :projects, only: [:index, :new, :edit, :create, :update, :destroy]
    resources :named_filters, only: [:index, :new, :edit, :create, :update, :destroy]
    resources :collaborators, only: [:index, :new, :edit, :create, :update,
                                     :destroy] do
      put :sort
    end
    resources :topics, only: [:index, :new, :edit, :create, :update, :destroy] do
      put :sort
      put :sort_name, on: :collection
      put :sort_date, on: :collection
    end
    resources :themes, only: [:index, :new, :edit, :create, :update, :destroy] do
      put :sort
      put :sort_name, on: :collection
      put :sort_date, on: :collection
    end
    resources :document_types, path: '/document-types', only: [
      :index, :new, :edit, :create, :update, :destroy
    ] do
      put :sort
      put :sort_name, on: :collection
    end
    resources :reference_types, path: '/reference-types', only: [
      :index, :new, :edit, :create, :update, :destroy
    ] do
      put :sort
      put :sort_name, on: :collection
      put :sort_date, on: :collection
    end
    resources :languages, only: [:index, :new, :edit, :create, :update, :destroy] do
      put :sort
      put :sort_name, on: :collection
    end
    resources :regions, only: [:index, :new, :edit, :create, :update, :destroy] do
      put :sort
      put :sort_name, on: :collection
      put :sort_date, on: :collection
    end
    resources :tags, only: [:index, :new, :edit, :create, :update, :destroy] do
      put :sort
      put :sort_name, on: :collection
      put :sort_date, on: :collection
    end
    resources :eras, only: [:index, :new, :edit, :create, :update, :destroy] do
      put :sort
      put :sort_name, on: :collection
    end
    resources :miscs, only: [:index, :new, :edit, :create, :update, :destroy] do
      put :sort
    end
    resources :documents, only: [:new, :edit, :create, :update, :destroy] do
      collection do
        get 'published'
        get 'unpublished'
      end
    end

    resources :attached_files, only: [:index, :create]
  end

  authenticate :user, lambda {|u| u.is_editor? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  get '*slug', controller: 'misc', action: 'show'
  get "/web/viewer", :to => redirect('/web/viewer.html')
end

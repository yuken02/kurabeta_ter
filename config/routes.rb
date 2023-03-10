Rails.application.routes.draw do
  devise_for :users, controllers: {
   registrations: 'users/registrations',
   sessions: 'users/sessions',
   omniauth_callbacks: 'users/omniauth_callbacks'
  }

  root to: 'homes#top'
  get 'about' => 'homes#about'
  get '/auth/:provider/callback' => 'sessions#create'
  get 'search' => 'searches#index'
  # get 'edit' => 'searches#edit'
  resources :trends, only: [:index]
  # resources :searches, only: [:edit]
  resources :tabs, only: [:create, :update]
  resources :keywords, only: [:create, :destroy]
  resources :users, only: [:show, :edit, :update]

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

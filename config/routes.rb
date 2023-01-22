Rails.application.routes.draw do
  devise_for :users, controllers: {
   registrations: 'users/registrations',
   sessions: 'users/sessions',
   omniauth_callbacks: 'users/omniauth_callbacks'
  }

  root to: 'homes#top'
  get '/auth/:provider/callback', to: 'sessions#create'
  get 'search' => 'searches#index'
  resources :trends, only: [:index]
  resources :tabs, only: [:create, :update]
  resources :keywords, only: [:create, :destroy]
  resources :users, only: [:show, :edit, :update]

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

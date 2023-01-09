Rails.application.routes.draw do
  devise_for :users, controllers: {
   registrations: 'users/registrations',
   sessions:      'users/sessions',
}

  root to: 'homes#top'
  resources :trends, only: [:index]
  resources :searchs, only: [:index, :update, :create, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

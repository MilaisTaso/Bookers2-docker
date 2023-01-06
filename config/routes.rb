Rails.application.routes.draw do
  devise_for :users
  get 'searches/search', as: 'search'

  root to: "homes#top"
  get "home/about", to: "homes#about", as: 'about'

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationship, only:[:create, :destroy]
    member do
      get :following, :followers
    end
  end
  resources :rooms, only: [:show, :create]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

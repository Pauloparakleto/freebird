Rails.application.routes.draw do
  get 'reviews/new'
  get 'reviews/create'
  devise_for :users
  root to: "pages#home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/search", to: "projects#search"

  resources :events
  resources :projects do
    resources :reviews, only: [ :new, :create ]
  end
  resources :reviews, only: [ :show, :edit, :update, :destroy ]

  # events nested to use projects_id
  resources :projects do
    resources :events, only: [ :new, :create ]
  end

  resources :events, only: [ :show, :index, :edit, :update, :destroy]
end

Rails.application.routes.draw do
  root 'home#show'
  get 'search_item', to: 'items#search'
  get 'my_items', to: 'items#my_items'
  devise_for :users, controllers: {registratons: 'users/registrations'}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:edit, :show] do
    resource :friendships, only: [:create, :destroy, :show]
    member do
      get :follows, :followers, :favorites, :items
    end
  end

  get 'my_friends', to: 'users#my_friends'
  get 'search_friend', to: 'users#search'
  resources :items do
    collection do
      get 'search'
    end
    resources :articles, only: [:create]
    resources :likes, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]

  end
  # xxx
  post "items/:item_id/articles/new" => "articles#create"
end

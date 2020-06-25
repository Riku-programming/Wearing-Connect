Rails.application.routes.draw do
  root 'home#show'
  get 'search_item', to: 'items#search'
  get 'my_items', to: 'items#my_items'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:show] do
    resource :friendships, only: [:create, :destroy, :show]
    member do
      get :follows, :followers, :favorites, :items, :like
    end
  end

  get 'search_friend', to: 'users#search'
  post 'save', to: 'items#save'
  resources :items do
    collection do
      get 'get_category_children', defaults: {format: 'json'}
      get 'get_category_grandchildren', defaults: {format: 'json'}
      get 'search'
    end
    resources :likes, only: [:create, :destroy]
  end
end

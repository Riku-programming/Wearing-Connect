Rails.application.routes.draw do
  get 'search_item', to: 'items#search'
  get 'my_items', to: 'items#my_items'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    # get '/users/:id' => 'devise/sessions#show'
  end

  root 'home#show'
  get 'my_friends', to: 'users#my_friends'
  get 'search_friend', to: 'users#search'
  resources :friendships, only: [:create, :destroy, :show]
  resources :users, only: [:show]
  shallow do
    resources :items do
      resources :articles do
        resource :favorites, only: [:create, :destroy]
      end

    end
  end
  # xxx
  post "items/:item_id/articles/new" => "articles#create"
end

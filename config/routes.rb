Rails.application.routes.draw do
  get 'articles/index'
  root 'home#index'
  get 'show', to: 'home#show'

  resources :articles

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end

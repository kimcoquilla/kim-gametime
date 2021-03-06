Rails.application.routes.draw do
  resources :games do
    resources :reviews, only: :create
  end
  resources :reviews, only: :destroy

  devise_for :users
  root to: 'games#index'
  post 'score', to: 'games#score'
  post 'capital', to: 'games#capital'
  post 'flag', to: 'games#flag'

  resources :users

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

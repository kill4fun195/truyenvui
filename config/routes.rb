Rails.application.routes.draw do

  devise_for :users, :controllers =>{ :omniauth_callbacks => "omniauth_callbacks" }

  resources :posts
  resources :users do
    member do
      get "truyen"
    end
    collection do
      get "info"
    end
  end
  
  resources :categories
  
  get '/truyencuoi' => 'posts#truyencuoi'
  get '/user' => 'frontend/users#index'
  root "posts#anh_che"


end

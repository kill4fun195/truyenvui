Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers =>{ :omniauth_callbacks => "omniauth_callbacks" }

  resources :posts do
    collection do
      get "update_like"
      get "the_end"
      get "update_comment"
      get "hot"
    end
  end
  resources :users do
    member do
      get "truyen"
    end
    collection do
      get "info"
      get "top_user_week"
      get "top_user_month"
      get "top_user_total"
    end
  end
  
  resources :categories
  
  get '/truyencuoi' => 'posts#truyencuoi'
  get '/user' => 'frontend/users#index'
  root "posts#anh_che"
  get '/het' => 'posts#the_end'
  get '/top-user/week' => 'users#top_user_week'
  get '/top-user/month' => 'users#top_user_month'
  get '/top-user/total' => 'users#top_user_total'

end

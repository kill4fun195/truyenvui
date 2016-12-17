Rails.application.routes.draw do

  get '/truyencuoi' => 'frontend/jokes#index'
  get '/user' => 'frontend/users#index'
  root "frontend/pictures#index"

end

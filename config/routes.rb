Rails.application.routes.draw do

  mount_devise_token_auth_for 'User', at: 'auth'

  resources :bikes, only: [:index, :create, :show, :update, :destroy]
  
  root to: 'home#index'
  get '/about' => 'home#about'
  get '/secure' => 'home#secure'

end

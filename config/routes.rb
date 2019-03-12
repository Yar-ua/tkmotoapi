Rails.application.routes.draw do

  mount_devise_token_auth_for 'User', at: 'auth'

  resources :bikes, only: [:index, :create, :show, :update, :destroy] do
    resources :fuels, only: [:index, :create, :update, :destroy]
    resources :repairs, only: [:index, :create, :update, :destroy]
  end
  
  root to: 'home#index'
  get '/about' => 'home#about'
  get '/secure' => 'home#secure'

end

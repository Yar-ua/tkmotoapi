Rails.application.routes.draw do

  mount_devise_token_auth_for 'User', at: 'auth'

  # root for user config
  get 'user_config/show' => 'user_config#show', as: 'config'
  put 'user_config/update' => 'user_config#update', as: 'config_update'

  resources :bikes, only: [:index, :create, :show, :update, :destroy] do
    resources :fuels, only: [:index, :create, :update, :destroy]
    resources :repairs, only: [:index, :create, :update, :destroy]
    get '/config' => 'bike_config#show', as: 'bike_config'
    put '/config' => 'bike_config#update', as: 'bike_config_upd'
  end
  
  root to: 'home#index'
  get '/about' => 'home#about'
  get '/secure' => 'home#secure'

end

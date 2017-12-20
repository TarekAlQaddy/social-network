Rails.application.routes.draw do
  resources :friendships, only: [:index, :create, :destroy]

  resources :posts, only: [:index, :create, :destroy]

  mount_devise_token_auth_for 'User', at: 'auth'
end

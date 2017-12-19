Rails.application.routes.draw do
  # TODO: make this optional
  get 'user/:id' => 'user#show'

  resources :friendships, only: [:index, :create, :destroy]
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

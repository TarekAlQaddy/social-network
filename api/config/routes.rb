Rails.application.routes.draw do
  # TODO: make this optional
  get 'user/:id' => 'user#show'
  get 'user' => 'user#fetch_current_user'

  # resources :friendships, only: [:index, :create]
  get 'friendships' => 'friendships#index'
  post 'friendships' => 'friendships#create'
  delete 'friendships' => 'friendships#destroy'

  mount_devise_token_auth_for 'User', at: 'auth'
end

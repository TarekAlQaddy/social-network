Rails.application.routes.draw do
  resources :friend_requests, except: [:update]
  get 'friend_requests/sent' => 'friend_requests#sent_index'
  post 'friend_requests/accept/:id' => 'friend_requests#confirm'
  post 'friend_requests/reject/:id' => 'friend_requests#reject'

  # TODO: make this optional
  get 'user/:id' => 'user#show'
  get 'user' => 'user#fetch_current_user'

  # resources :friendships, only: [:index, :create]
  get 'friendships' => 'friendships#index'
  post 'friendships' => 'friendships#create'
  delete 'friendships' => 'friendships#destroy'

  mount_devise_token_auth_for 'User', at: 'auth'
end

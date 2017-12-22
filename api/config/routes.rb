Rails.application.routes.draw do
  post 'search' => 'search#search'
  resources :friend_requests, except: [:update]
  get 'friend_requests/sent' => 'friend_requests#sent_index'
  resources :friend_requests, except: [:update]
  post 'friend_requests/accept/:id' => 'friend_requests#confirm'
  post 'friend_requests/reject/:id' => 'friend_requests#reject'

  # TODO: make this optional
  get 'user/:id' => 'user#show'
  get 'user' => 'user#fetch_current_user'
  post 'add_phone' => 'user#add_phone'
  delete 'delete_phone' => 'user#delete_phone'

  # resources :friendships, only: [:index, :create]
  get 'friendships' => 'friendships#index'
  post 'friendships' => 'friendships#create'
  delete 'friendships' => 'friendships#destroy'

  # Update profile picture route
  post '/user/image' => 'user#update_profile_image'

  resources :posts, only: [:index, :create, :destroy]
  get 'profile' => 'posts#profile'   # Get current user posts 'profile page'

  mount_devise_token_auth_for 'User', at: 'auth'
end

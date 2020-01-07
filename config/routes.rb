Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # set root
  root 'root#root'

  # users controller
  resource :user, controller: 'users', except: %i[show create destroy], param: :userId
  get '/user/:userId', to: 'users#show'
  get '/users', to: 'users#show_many'
  post '/signup', to: 'users#create'
  post '/signup/complete', to: 'users#create_complete'
  get '/emailcheck', to: 'users#emailcheck_get'
  post '/emailcheck', to: 'users#emailcheck_post'
  get '/edit/emailcheck', to: 'users#edit_emailcheck'
  post '/edit/emailcheck/complete', to: 'users#edit_emailcheck_complete'

  # follows controller
  put '/follow/:userId', to: 'follows#update'
  patch '/follow/:userId', to: 'follows#update'
  get '/follow/status', to: 'follows#follow_status_get'
  get '/follower', to: 'follows#follower_get'
  get '/following', to: 'follows#following_get'
  post '/following', to: 'follows#following_post'
  delete '/follow/following/:userId', to: 'follows#destroy_following'
  delete '/follow/follower/:userId', to: 'follows#destroy_follower'

  # auth controller
  resource :auth, controller: 'auths', only: %i[create update]

  # tweet controller
  resources :tweet, controller: 'tweets', only: %i[show create destroy], param: :tweetId
  post '/like/:tweetId', to: 'tweets#like_post'
  get '/tweets/:userId', to: 'tweets#show_many'
  get '/timeline', to: 'tweets#timeline_get'

  # image controller
  resources :image, controller: 'images', only: %i[show], param: :imageId
  get '/images/:tweetId', to: 'images#show_many'

  # comment controller
  resources :comment, controller: 'comments', only: %i[show create destroy], param: :commentId
end

Rails.application.routes.draw do
  root 'feed#feed'

  get 'feed.:format', to: 'feed#feed'

  get  'login', to: 'user#login'
  post 'login', to: 'user#login_check'
  get  'signup', to: 'user#signup'
  post 'signup', to: 'user#create'
  get  'logout', to: 'user#logout'
  get 'account', to: 'user#my_account'
  patch 'account', to: 'user#update'
  
  get 'search', to: 'user#search'

  get 'timeline', to: 'feed#timeline'

  namespace :messages, path: 'messages' do
    root action: 'index'
    # put '/new', action: 'new'
    post '/', action: 'index_ajax'
    put  '/', action: 'create_chat'
    get  '/:id', action: 'show'
    put  '/:id', action: 'create_message'
    get  '/:id/older', action: 'older_messages'
    get  '/:id/newer', action: 'new_messages'
  end

  namespace :feed, path: 'feed' do
    post 'new_post', action: 'create'
    get '/official', action: 'official_feed'
    get '/user/:user_id', action: 'user_feed'
    get '/user/:user_id/:post_id', action: 'show'
    get '/user/:user_id/:post_id/replies', action: 'show_replies'
    patch '/user/:user_id/:id', action: 'update'
    delete '/user/:user_id/:id', action: 'delete'
    post '/user/:user_id/:post_id/comment', action: 'create_reply'
  end

  namespace :group, path: 'group' do
    root action: 'index'
    post  '/', action: 'index_ajax'
    get   'new', action: 'new'
    post  'new', action: 'create'
    get   '/search', action: 'search'
    post  '/search', action: 'search'
    get   ':id', action: 'show'
    patch ':id', action: 'update'
    get   ':id/members', action: 'members'
    post  ':id/members', action: 'members_ajax'
    get   ':id/members/:user_id', action: 'membership'
    patch ':id/members/:user_id', action: 'update_membership'
    post  ':id/members/:user_id/ban', action: 'ban'
    post  ':id/new_post', action: 'create_post'
    get   ':id/join', action: 'join'
    get   ':id/leave', action: 'leave'
    post  ':id/delete', action: 'delete'
    get   ':id/posts/:post_id', action: 'show_post'
    post  ':id/posts/:post_id/comment', action: 'create_reply'
    post  ':id/posts/:post_id/pin', action: 'pin'
  end

  namespace :user, path: 'user' do
    get '/forgot_password', action: 'forgot_password'
    post '/forgot_password', action: 'forgot_password_check'
    get '/forgot_password/:activation_id', action: 'reset_password'
    post '/forgot_password/:activation_id', action: 'reset_password_check'
    get ':id', action: 'show'
    get ':id/message', action: 'direct_message'
    get ':id/follow', action: 'follow'
  end

  scope :ajax do
    namespace :user, path: 'user' do
      post 'hide', action: 'profile_hide'
    end
  end

  get 'stats', to: 'static#stats'

  get 'terms', to: 'static#terms'
  get 'faq', to: 'static#faq'
  get 'privacy', to: 'static#privacy'
  get 'license', to: 'static#license'
end

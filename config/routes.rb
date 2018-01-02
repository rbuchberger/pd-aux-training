Rails.application.routes.draw do
  root to: 'pages#home'
  
  # Routes for users to register and edit their logins & profiles
  devise_for :users

  # Routes for users to CRUD their own timecards:
  resources :timecards
  
  # Routes for training videos
  resources :training_videos do
    resources :training_records, only: [:create, :destroy, :index]
  end
  
  # Administration related routes for managing other users:
  scope '/admin' do
    resources :users, except: [:new, :create] do
      resources :timecards, only: [:index, :show]
      resources :training_records, only: [:index, :destroy]
    end
    # Admin timecard index and filters
    get 'timecards/(:user_id)', to: 'timecards#admindex', as: 'admin_timecards'
    # Custom route to allow trainers to approve pending users, but not change other users' roles. 
    put 'users/:id/accept', to: 'users#approve', as: 'accept_user'
    # Custom route that allows trainers to delete users who haven't been approved yet, but nobody else. 
    delete 'users/:id/reject', to: 'users#reject', as: 'reject_user'
  
  end
  
end

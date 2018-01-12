Rails.application.routes.draw do
  root to: 'pages#home'
  
  # Routes for users to register and edit their logins & profiles
  devise_for :users, controllers: {registrations: 'users/registrations'}
  
  # Administration related routes for managing other users:
  scope '/admin' do
    resources :users, except: [:new, :create] do
      member do
        get 'training_requirements'
        patch 'deactivate'
        patch 'reactivate'
        patch 'approve'
        delete 'reject'
      end
    end
    
    # Training records index
    resources :training_records, only: :index

    # Admin timecard index and filters
    get 'timecards/(:user_id)', to: 'timecards#admindex', as: 'admin_timecards'
  end
  
  # Routes for users to CRUD their own timecards:
  resources :timecards
  resources :training_records, only: :destroy
  # Routes for training videos
  resources :training_requirements do
    member do
      post 'training_records', to: 'training_records#create'
      get 'users'
    end
  end
  
end

Rails.application.routes.draw do
  root to: 'pages#home'
  
  # Routes for users to register and edit their logins & profiles
  devise_for :users, controllers: {registrations: 'users/registrations'}
  
  # Administration related routes for managing other users:
  scope '/admin' do
    resources :users, except: [:new, :create] do
      member do
        get 'lessons'
        patch 'deactivate'
        patch 'reactivate'
        patch 'approve'
        delete 'reject'
      end
    end
    
    # Training completions index
    resources :completions, only: :index

    # Admin timecard index and filters
    get 'timecards/(:user_id)', to: 'timecards#admindex', as: 'admin_timecards'

    # Bulletin management
    resources :bulletins, except: [:show, :index]
  end
  
  # Routes for users to CRUD their own timecards:
  resources :timecards
  # Routes for lessons
  resources :completions, only: :destroy
  resources :lessons do
    member do
      post 'completions', to: 'completions#create'
      get 'users'
    end
  end

  resources :bulletins, only: [:show]
  
end

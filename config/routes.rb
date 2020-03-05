Rails.application.routes.draw do
  root to: 'pages#home'
  get 'about', to: 'pages#about'

  # Routes for users to register and edit their logins & profiles
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # Routes for users to CRUD their own timecards:
  resources :timecards

  # Routes for the document library
  resources :documents, except: %i[new edit]

  # Routes for lessons
  resources :completions, only: :destroy
  resources :lessons do
    member do
      post 'completions', to: 'completions#create'
      get 'users'
    end
  end

  # Administration related routes:
  scope '/admin' do
    resources :users, except: %i[new create] do
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
    resources :bulletins, except: %i[show index]

    # Document library
    resources :documents, only: %i[new edit]
  end
end

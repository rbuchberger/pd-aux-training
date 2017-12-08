Rails.application.routes.draw do
  root to: 'pages#home'
  # Routes for users to register and edit their logins & profiles
  devise_for :users
  scope '/admin' do
    resources :users, except: [:new, :create]
  end
  
end

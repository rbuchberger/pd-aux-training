source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
# Lock in current version of ruby. 
ruby '2.4.0'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.11', platforms: :ruby
# Use devise for user registration
gem 'devise', '4.4.0'
# Use Pundit for access control
gem 'pundit', '1.1.0'
# Twitter bootstrap for to make it pretty
gem 'bootstrap', '~> 4.0.0.beta2.1'
# jQuery for javascript 
gem 'jquery-rails', '4.3.1'
# Hirb gem for database convenience
gem 'hirb', '~> 0.7.3'
# Mailgun
gem 'mail', '~> 2.6', '>= 2.6.4'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
end

group :development do
  # Use Capistrano for deployment
  # gem 'capistrano-rails', group: :development
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end

group :production do
  # Heroku needs postgres
  gem 'pg', '~> 0.18.4'
  
end


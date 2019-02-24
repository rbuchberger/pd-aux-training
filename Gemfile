# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Lock in current version of ruby.
ruby '2.5.3'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.1'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 4.1.0'
# Turbolinks for pseudo-javascript front-end.
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease.
gem 'jbuilder', '~> 2.5'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1', platforms: :ruby
# Use devise for user registration
gem 'devise', '~>4'
# Use Pundit for access control
gem 'pundit', '~>2'
# Twitter bootstrap for to make it pretty
gem 'bootstrap', '~> 4.0'
# jQuery for javascript
gem 'jquery-rails', '4.3.1'
# Hirb gem for database convenience
gem 'hirb', '~> 0.7.3'
# Redcarpet to enable markdown rendering
gem 'redcarpet'
# Paperclip gem for file uploads
gem 'paperclip', '~> 6.0.0'
# Amazon AWS S3 for library file storage
gem 'aws-sdk-core', '~> 3'
gem 'aws-sdk-s3', '~> 1'

group :development, :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
  # gem 'aws-sdk'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere
  # in the code.
  gem 'web-console', '>= 3.3.0'
end

group :production, :staging do
  # Heroku needs postgres
  gem 'pg', '~> 0.18.4'
end

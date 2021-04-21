# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Lock in current version of ruby.
ruby '2.7.2'
gem 'rails', '~> 6.0'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sassc-rails', '~> 2.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 4.1'
# Turbolinks for pseudo-javascript front-end.
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease.
gem 'jbuilder', '~> 2.5'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1', platforms: :ruby
# Use devise for user registration
gem 'devise', '~>4.7'
# Use Pundit for access control
gem 'pundit', '~>2'
# Twitter bootstrap for to make it pretty
gem 'bootstrap', '~> 4.0'
# jQuery for javascript
gem 'jquery-rails', '4.3'
# Hirb gem for database convenience
gem 'hirb', '~> 0.7'
# Redcarpet to enable markdown rendering
gem 'redcarpet'
# Amazon AWS S3 for library file storage
gem 'aws-sdk-core', '~> 3'
gem 'aws-sdk-s3', '~> 1'

group :development, :test do
  gem 'capybara', '~> 2.13'
  gem 'listen'
  gem 'selenium-webdriver'
  gem 'solargraph'
  gem 'sqlite3', '~> 1.3'
end

group :development do
  gem 'byebug'
  gem 'rubocop-rails', '~> 2.9.1', require: false
  gem 'web-console', '>= 3.3'
end

group :production do
  gem 'pg', '~> 1.1'
end

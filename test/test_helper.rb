require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'capybara/minitest'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  
  def valid_user_params
    {
    first_name: 'Stan',
    last_name: 'Beaudry',
    badge_number: 'x15',
    email: 'stantheman@example.com',
    role: :pending,
    password: '123456',
    password_confirmation: '123456'
    }
  end
  
  def valid_timecard_params
    {
      # user_id: users(:deputy).id,
      description: 'Raiding Panties',
      start: Time.zone.now - 20.days,
      end: Time.zone.now - 20.days + 5.hours,
    }
  end
  
  def valid_training_requirement_params
    {
    title: "How to apply handcuffs", 
    description: "I know someone who's into this stuff.", 
    training_video_attributes: {
    url: "https://www.youtube.com/watch?v=PdDu9T1EbWM", 
    }}
  end
  
  def valid_training_record_params
    {
      user_id: 1,
      training_video_id: 1
    }
  end
  
end

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL
  # Make `assert_*` methods behave like Minitest assertions
  include Capybara::Minitest::Assertions
  include Warden::Test::Helpers
  # Reset sessions and driver between tests
  # Use super wherever this method is redefined in your individual test classes
  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
    Warden.test_reset!
  end
end

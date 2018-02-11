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
      description: 'Raiding Panties',
      field_clock_in_date:  Time.zone.now.strftime("%Y-%m-%d"),
      field_clock_in_time:  Time.zone.now, 
      field_clock_out_time: Time.zone.now + 2.hours
    }
  end
  
  def valid_lesson_params
    {
    title: "How to apply handcuffs", 
    description: "I know someone who's into this stuff.", 
    video_attributes: {
    url: "https://www.youtube.com/watch?v=PdDu9T1EbWM", 
    }}
  end
  
  def valid_completion_params
    {
      user_id: 1,
      lesson_id: 1
    }
  end

  def valid_bulletin_params
    { 
      user_id: 1,
      title: "Hello World",
      body: "I have a body."
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

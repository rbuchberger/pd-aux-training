require File.expand_path('../config/environment', __dir__)
require 'rails/test_help'
require 'capybara/rails'
require 'capybara/minitest'

class ActiveSupport::TestCase
  # Required for fixture_file_upload
  include ActionDispatch::TestProcess
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # I'm sure there's some built in way to do this, but I couldn't find one that
  # worked well.
  def compare_datetimes(a, b)
    are_equal = true
    are_equal = false unless a.year  == b.year
    are_equal = false unless a.month == b.month
    are_equal = false unless a.day   == b.day
    are_equal = false unless a.hour  == b.hour
    are_equal = false unless a.min   == b.min
    are_equal
  end

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
      user_id: 1,
      description: 'Raiding Panties',
      clock_in_date: Date.new(2015, 12, 31),
      clock_in_time: Time.zone.parse('2017-12-31 12:30'),
      clock_out_time: Time.zone.parse('2018-1-1 02:30')
    }
  end

  def valid_lesson_params
    {
      title: 'How to apply handcuffs',
      description: "I know someone who's into this stuff.",
      video_attributes: {
        url: 'https://www.youtube.com/watch?v=PdDu9T1EbWM'
      }
    }
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
      title: 'Hello World',
      body: 'I have a body.'
    }
  end

  def valid_document_params
    file = fixture_file_upload('test.txt')

    {
      name: 'Valid Document',
      description: "I'm a document!",
      file: file
    }
  end

  def blank_timecard_presenter_params
    {
      user_id: '',
      range_start: '',
      range_end: ''
    }
  end

  def stub_aws
    Aws.config[:s3] = { stub_responses: true }
  end

  def unstub_aws
    Aws.config[:s3] = { stub_responses: false }
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

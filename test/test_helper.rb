require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

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
  
  def valid_video_params
    {
    title: "How to apply handcuffs", 
    description: "I know someone who's into this stuff.", 
    url: "https://www.youtube.com/watch?v=PdDu9T1EbWM", 
    }
  end
  
  def valid_training_record_params
    {
      user_id: 1,
      training_video_id: 1
    }
  end
  
end

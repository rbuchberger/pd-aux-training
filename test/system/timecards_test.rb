require "application_system_test_case"

class TimecardTest < ApplicationSystemTestCase
  # Deputy tests 
  
    # Log timecard
    test 'log timecard' do
      login_as(users(:deputy))
      visit root_path
      click_link 'Timecards'
      click_button 'Log new workday'
      fill_in('Description', with: 'I AM DEFINITELY A HUMAN.')
      # For 15 minutes after midnight every day, this test will fail. Yes, I'm lazy.
      select('00', from: 'timecard_start_4i')
      select('01', from: 'timecard_start_5i')
      click_button 'Log it!'

      assert_text 'Timecard logged!'
      assert_selector 'h4', text: 'Timecards for'
      assert_text 'I AM DEF'
    end

end

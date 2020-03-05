require 'application_system_test_case'

class TrainingRecordsTest < ApplicationSystemTestCase
  test 'log timecard' do
    login_as(users(:deputy))
    visit root_path
    click_link 'Timecards'
    click_button 'Log new workday'
    fill_in('Description', with: 'I AM DEFINITELY A HUMAN.')
    select('00', from: 'timecard_start_41')
    click_button 'Log it!'
    assert_text 'Timecard logged!'
  end
end

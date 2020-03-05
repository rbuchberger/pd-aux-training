require 'test_helper'

class TimecardsPresenterTest < ActionDispatch::IntegrationTest
  include TimecardsPresenter

  # Initialization tests:
  # params, user, admindex

  # none, none, false
  # Should throw an error
  test 'bad arguments' do
    p = blank_timecard_presenter_params
    assert_raises ArgumentError do
      FilteredTimecards.new(params: p, user: nil, admindex: false)
    end
  end

  # none, none, true
  # Should return all users, last 30 days
  test 'admindex defaults' do
    p = blank_timecard_presenter_params
    t = FilteredTimecards.new(params: p, user: nil, admindex: true)

    assert_equal t.user.first_last, 'All Users'
    assert_equal t.range_start,
                 Time.zone.now.to_date.beginning_of_day - 30.days
    assert_equal t.range_end,
                 Time.zone.now.to_date.end_of_day
  end

  # none, user, false
  # Should return given user, last 30 days
  test 'index defaults' do
    u = users(:deputy)
    p = blank_timecard_presenter_params
    t = FilteredTimecards.new(params: p, user: u, admindex: false)

    assert_equal t.list.first.user.id, u.id
    assert_equal t.range_start, Date.today.beginning_of_day - 30.days
    assert_equal t.range_end, Date.today.end_of_day
  end

  # different user, current_user, false
  # Shoud ignore user in params
  test 'ignore params user' do
    u = users(:deputy)
    p = blank_timecard_presenter_params
    p[:user_id] = users(:admin).id
    t = FilteredTimecards.new(params: p, user: u, admindex: false)

    assert_equal t.list.first.user.id, u.id
  end

  # start & end date, none, true
  # Should return all users, given dates
  test 'admindex range specified' do
    s = Date.today - 20.days
    s = s.strftime('%Y-%m-%d')
    f = Date.today - 10.days
    f = f.strftime('%Y-%m-%d')
    p = { range_start: s, range_end: f, user_id: '' }
    t = FilteredTimecards.new(params: p, user: nil, admindex: true)

    assert_equal t.user.first_last, AllUsers.new.first_last
    assert_equal s, t.formatted_range_start
    assert_equal f, t.formatted_range_end
  end

  # Total duration
  test 'total duration' do
    p = blank_timecard_presenter_params
    t = FilteredTimecards.new(params: p, user: nil, admindex: true)

    assert_instance_of Float, t.total_duration
  end

  # SelectOptions:
  test 'select options' do
    t = SelectOptions.new
    u = User.create(valid_user_params)

    assert_instance_of Hash, t.list
    assert_difference 't.list.size', 1 do
      t.add(u)
    end
  end
end

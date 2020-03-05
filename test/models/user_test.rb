require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # I'm not gonna test all the functions of devise. Presumably the devise team
  # tests their software, I'll test the parts I touch.

  # Should have a first name
  test 'has first name' do
    t = User.new(valid_user_params)
    t.first_name = ''

    assert_not t.save
  end

  # First name format
  test 'first name format' do
    t = User.new(valid_user_params)
    t.first_name = 'a' * 31
    assert_not t.save
    t.first_name = 'Robert%'
    assert_not t.save
    t.first_name = 'Robert 534'
    assert_not t.save
  end

  # Should have a last name
  test 'has last name' do
    t = User.new(valid_user_params)
    t.last_name = ''

    assert_not t.save
  end

  # Last name format
  test 'last name format' do
    t = User.new(valid_user_params)
    t.last_name = 'a' * 31
    assert_not t.save
    t.last_name = 'Buchberger%'
    assert_not t.save
    t.last_name = 'Buchberger 534'
    assert_not t.save
  end

  # Should have a badge number
  test 'has badge number' do
    t = User.new(valid_user_params)
    t.badge_number = ''

    assert_not t.save
  end

  # Badge number format
  test 'badge number format' do
    t = User.new(valid_user_params)

    t.badge_number = '1234'
    assert_not t.save

    t.badge_number = 'Y-05'
    assert_not t.save

    t.badge_number = '805'
    assert_not t.save
  end

  # Should standardize string fields before save
  test 'format strings' do
    t = User.new(valid_user_params)
    t.first_name = 'robert  a   '
    t.last_name = '  buchberger ix   '
    t.badge_number = 'x05'

    assert t.save

    assert_equal t.first_name, 'Robert A'
    assert_equal t.last_name, 'Buchberger IX'
    assert_equal t.badge_number, 'X-5'

    t.badge_number = 'x-20'

    assert t.save
    # Make sure it doesn't strip out trailing 0s!
    assert_equal t.badge_number, 'X-20'
  end

  # Newly created users should be set to pending
  test 'pending new' do
    t = User.new(valid_user_params)
    t.role = :admin
    t.save

    assert t.role = :pending
  end

  # pending users should not be considered active for authentication
  test 'pending active' do
    t = User.unscoped.create(valid_user_params)

    assert_not t.active_for_authentication?
  end

  # first_last(length) custom method
  test 'first last' do
    t = users(:admin)

    assert t.first_last == 'Austin Powers'
  end

  # last_first(length) custom method
  test 'last, first' do
    t = users(:admin)

    assert t.last_first == 'Powers, Austin'
  end

  # admins should be trainers too
  test 'admins are trainers' do
    t = users(:admin)

    assert t.trainer?
  end

  # Deactivate account
  test 'deactivate' do
    t = users(:trainer)
    t.deactivate

    assert t.deleted_at
    assert t.deputy?
  end

  # Reactivate account
  test 'reactivate' do
    t = users(:trainer)

    t.deactivate
    t.reactivate

    assert_not t.deleted_at
    assert t.deputy?
  end

  # Last admin account can't be deactivated
  test 'last admin deactivate' do
    User.where(role: :admin).each(&:deactivate)

    t = User.where(role: :admin)

    assert_not_empty t
  end

  # Last admin can't be deleted
  test 'last admin destroy' do
    User.where(role: :admin).each(&:destroy)

    t = User.where(role: :admin)

    assert_not_empty t
  end
end

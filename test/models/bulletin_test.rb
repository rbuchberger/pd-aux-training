require 'test_helper'

class BulletinTest < ActiveSupport::TestCase
  # The bulletin model is pretty simple. 
  # I'm not writing tests for basic rails functionality such as validations. 

  test "Cache fetch" do
    Rails.cache.delete('bulletins')

    t = Bulletin.all_cached.count
    last_30 = Bulletin.last(30).count

    assert_equal t, last_30
  end

  test "clear_cache" do
    t = Bulletin.all_cached.count
    Bulletin.create(valid_bulletin_params)

    assert_not_equal t, Bulletin.all_cached.count
  end

end

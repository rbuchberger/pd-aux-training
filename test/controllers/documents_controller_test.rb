require 'test_helper'

# Deputy tests
class DocumentsControllerDeputyTest < ActionDispatch::IntegrationTest

  setup do
    stub_aws
    sign_in_users[:deputy]
  end

  teardown do
    unstub_aws
  end

  # index

  # show

  # new

  # create

  # edit

  # update

  # destroy

end

# Trainer tests
class DocumentsControllerTrainerTest < ActionDispatch::IntegrationTest

  setup do
    stub_aws
    sign_in_users[:trainer]
  end

  teardown do
    unstub_aws
  end

  # new

  # create

  # edit

  # update

  # destroy

end

# Not logged in tests
class DocumentsControllerGuestTest < ActionDispatch::IntegrationTest

  setup do
    stub_aws
  end

  teardown do
    unstub_aws
  end

  # index

  # show

  # new

  # create

  # edit

  # update

  # destroy

end

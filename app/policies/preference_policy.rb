class PreferencePolicy < ApplicationPolicy
  def disable_all_email?
    own_record?
  end

  def set_defaults?
    own_record?
  end

  def update?
    own_record?
  end

  # There are no index, create, or destroy related actions becuase they don't
  # make any sense. I'll add policies for them simply for the sake of
  # completeness. 

  def index? 
    false
  end

  def create?
    own_record?
  end

end

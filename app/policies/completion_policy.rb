class CompletionPolicy < ApplicationPolicy
  def index?
    @user.trainer?
  end
  
  def create?
    own_record?
  end
  
  def destroy? 
    own_record? # || @user.trainer?
  end
end

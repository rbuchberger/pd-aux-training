class TimecardPolicy < ApplicationPolicy
  
  def index?
    true
  end
  
  def show?
    own_record? || @user.trainer?
  end
  
  def create?
    true
  end
  
  def update?
    own_record?
  end
  
  def destroy?
    own_record? || @user.admin?
  end
  
  def admindex?
    @user.trainer?
  end
  
end
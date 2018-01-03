class TrainingVideoPolicy < ApplicationPolicy
  
  def index?
    true
  end
  
  def show?
    true
  end
  
  def create?
    @user.trainer?
  end
  
  def update?
    @user.trainer?
  end
  
  def destroy?
    @user.trainer?
  end
  
  def users?
    @user.trainer?
  end

end
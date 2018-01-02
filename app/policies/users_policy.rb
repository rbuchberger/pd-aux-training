class UserPolicy < ApplicationPolicy
  
  def index?
    @user.trainer?
  end
  
  def show?
    own_record? || @user.trainer? 
  end
  
  def create?
    false
  end
  
  def update?
    @user.admin?
  end
  
  def destroy?
    @user.admin?
  end
  
  def approve?
    @record.pending? && @user.trainer?
  end
  
  def reject?
    approve?
  end
  
end
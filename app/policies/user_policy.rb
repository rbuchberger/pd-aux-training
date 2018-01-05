class UserPolicy < ApplicationPolicy
  
  def index?
    @user.trainer?
  end
  
  def show?
    @user.trainer? || own_record?  
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
     @user.trainer? && @record.pending? 
  end
  
  def reject?
    approve?
  end
  
  def training_videos?
    own_record? || @user.trainer?
  end
  
end
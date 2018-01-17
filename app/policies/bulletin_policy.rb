class BulletinPolicy < ApplicationPolicy

  def index?
    true
  end

  def create?
    @user.trainer?
  end

  def update?
    @user.trainer? && own_record?
  end

  def destroy?
    @user.trainer?
  end

end

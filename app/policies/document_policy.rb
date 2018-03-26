class DocumentPolicy < ApplicationPolicy

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

  def download
    true
  end

end

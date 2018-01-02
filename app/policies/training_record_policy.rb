class TrainingRecordPolicy < ApplicationPolicy
  def index?
    current_user.trainer?
  end
  
  def create?
    own_record?
  end
  
  def destroy? 
    own_record? || current_user.trainer?
  end
end
class ApplicationPolicy
  attr_reader :user, :record

  # Policies are required by the pundit gem to control access to various
  # resources. 
  
  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    scope.where(id: record.id).exists?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if @user.trainer?
        scope.all
      else
        #
      end
    end
  end
  
  protected
  
  def own_record?
    if @record.class == User
      @record == @user
    else
      @record.user == @user
    end
  end
  
end

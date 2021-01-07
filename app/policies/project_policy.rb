class ProjectPolicy < ApplicationPolicy
  def index?
    user.Manager? or user.QA? or user.Developer
  end
  def new?
    user.Manager?
  end
  def create?
    user.Manager?
  end
  def show?
    user.Manager? or user.QA? or user.Develope
  end
  def edit?
    user.Manager?
  end

  def update
    user.Manager?
  end

  def destroy?
    user.Manager?
  end

end
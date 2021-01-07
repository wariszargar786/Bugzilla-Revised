class BugPolicy < ApplicationPolicy
  def new?
    user.QA?
  end
  def create?
    user.QA?
  end
  def edit?
    user.QA?
  end
  def update
    user.QA?
  end

end
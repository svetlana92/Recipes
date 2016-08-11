class UserPolicy < ApplicationPolicy
  def update?
    user == record
  end

  def edit?
    update?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end

class RecipePolicy < ApplicationPolicy
  def update?
    user.present? && user.owner_of?(record)
  end

  def edit?
    update?
  end

end

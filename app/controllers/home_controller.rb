class HomeController < ApplicationController
  def index
    @last_recipes = Recipe.includes(:categories).last(3)
    @popular_categories = Category.popular.limit(3)
    @popular_categories_projects = @popular_categories.map(&:recipes_count).
                                                       reduce(:+)
    @most_active_users = User.most_active.limit(5)
    @recent_users = User.first(5)
  end
end

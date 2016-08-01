class HomeController < ApplicationController
  def index
    @last_recipes = Recipe.includes(:categories).last(6)
  end
end

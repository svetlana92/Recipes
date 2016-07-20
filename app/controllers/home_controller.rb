class HomeController < ApplicationController
  def index
    @last_recipes = Recipe.last(6)
  end
end

class RecipesController < ApplicationController
  before_action :set_recipe, except: [:index, :new, :create]

  def index
    @recipes = Recipe.all
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_recipe
    @recipe = Recipe.find params[:id]
  end
end

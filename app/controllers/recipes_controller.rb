class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_recipe, except: [:index, :new, :create]
  before_action :authenticate_author, only: [:update, :edit]

  def index
    @recipes = Recipe.all
  end

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    if @recipe.save
      redirect_to @recipe
    else
      render 'new'
    end
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

  def recipe_params
    params.require(:recipe).permit(:name, :description, :image)
  end

  def authenticate_author
    if current_user != @recipe.user
      redirect_to recipes_path
      flash[:alert] = "Can't touch this, Ta-ra-ra-ra"
    end
  end
end

class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_recipe, except: [:index, :new, :create]
  before_action :authenticate_author, only: [:update, :edit]

  def index
    @recipes = Recipe.includes(:categories).search(params[:search])
  end

  def show
  end

  def new
    @recipe = Recipe.new
    @categories = Category.where parent: nil
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    if @recipe.save
      redirect_to @recipe
    else
      @categories = Category.where parent: nil
      render 'new'
    end
  end

  def edit
    @categories = Category.where parent: nil

  end

  def update
    if @recipe.update recipe_params
      redirect_to @recipe
    else
      @categories = Category.where parent: nil
      render 'new'
    end
  end

  def destroy
  end

  private

  def set_recipe
    @recipe = Recipe.find params[:id]
  end

  def recipe_params
    params.require(:recipe).permit(:name, :description, :image, category_ids: [])
  end

  def authenticate_author
    if current_user != @recipe.user
      redirect_to recipes_path
      flash[:alert] = "Can't touch this, Ta-ra-ra-ra"
    end
  end
end

class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_recipe, except: [:index, :new, :create]
  before_action :set_form_variables, exept: [:index, :show, :destroy]

  def index
    @recipes = Recipe.includes(:categories).search(params[:search])
  end

  def show
  end

  def new
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
    if @recipe.update recipe_params
      redirect_to @recipe
    else
      render 'edit'
    end
  end

  def destroy
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
    authorize(@recipe)
  end

  def recipe_params
    params.require(:recipe).permit(
      :name, :description, :image,
      category_ids: [],
      ingredients_attributes: [:id, :name, :quantity, :measure_id, :_destroy])
  end

  def authenticate_author
    if current_user != @recipe.user
      redirect_to recipes_path
      flash[:alert] = "Can't touch this, Ta-ra-ra-ra"
    end
  end

  def set_form_variables
    @recipe = Recipe.new if @recipe.blank?
    @measures = Measure.all
    @categories = Category.where parent: nil
    (2 - @recipe.ingredients.size).times { @recipe.ingredients.build }
  end
end

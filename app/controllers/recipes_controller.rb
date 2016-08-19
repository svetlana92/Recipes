class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_recipe, except: [:index, :new, :create]
  before_action :set_form_variables, except: [:index, :show, :destroy]

  def index
    @recipes = Recipe.includes(:categories).search(params[:search])
  end

  def show
  end

  def new
  end

  def create
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
    strong_params = params.require(:recipe).permit(
      :name, :description, :image,
      category_ids: [],
      ingredients_attributes: [:id, :product_id, :new_name, :quantity, :measure_id, :_destroy])

    modify_ingredient_attributes strong_params.to_h
  end

  def modify_ingredient_attributes(params_hash)
    old_attributes = params_hash[:ingredients_attributes]

    new_attributes = old_attributes.inject({}) do |hash, (key, value)|
      if !(value[:product_id] =~ /\A\d+\Z/)
        new_value = value
        new_value[:new_name] = new_value[:product_id]
        new_value[:product_id] = ''
        hash[key] = new_value
      else
        hash[key] = value
      end

      hash
    end

    params_hash[:ingredients_attributes] = new_attributes
    params_hash
  end

  def authenticate_author
    if current_user != @recipe.user
      redirect_to recipes_path
      flash[:alert] = "Can't touch this, Ta-ra-ra-ra"
    end
  end

  def set_form_variables
    @recipe = Recipe.new if params[:action] == 'new'
    @recipe = Recipe.new(recipe_params) if params[:action] == 'create'
    @measures = Measure.all
    @categories = Category.where parent: nil
    (2 - @recipe.ingredients.size).times { @recipe.ingredients.build }
    @products = Product.all
  end
end

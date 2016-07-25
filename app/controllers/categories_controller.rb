class CategoriesController < ApplicationController

  def index
    @categories = Category.where(parent_id: params[:parent_id])
    @new_level = params[:category_level].to_i + 1
    @category_number = params[:category_number].to_i
  end

  def show
    @category = Category.find params[:id]
  end
end

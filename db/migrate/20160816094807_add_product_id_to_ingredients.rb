class AddProductIdToIngredients < ActiveRecord::Migration[5.0]
  def change
    add_reference :ingredients, :product, index: true, foreign_key: true
  end
end

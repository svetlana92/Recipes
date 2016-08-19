class RemoveNameFromIngredients < ActiveRecord::Migration[5.0]
  def change
    remove_column :ingredients, :name, :string
  end
end

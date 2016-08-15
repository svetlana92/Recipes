class UpdateQuantityInIngredients < ActiveRecord::Migration[5.0]
  def up
    change_column :ingredients, :quantity, :float
  end

  def down
    change_column :ingredients, :quantity, :string
  end
end

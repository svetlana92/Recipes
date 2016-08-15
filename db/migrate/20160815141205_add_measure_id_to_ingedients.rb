class AddMeasureIdToIngedients < ActiveRecord::Migration[5.0]
  def change
    add_reference :ingredients, :measure, index: true, foreign_key: true
  end
end

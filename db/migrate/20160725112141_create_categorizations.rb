class CreateCategorizations < ActiveRecord::Migration[5.0]
  def change
    create_table :categorizations do |t|
      t.references :recipe, foreign_key: true, index: true
      t.references :category, foreign_key: true, index: true

      t.timestamps
    end
  end
end

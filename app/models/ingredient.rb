class Ingredient < ApplicationRecord
  belongs_to :recipe, inverse_of: :ingredients
  belongs_to :measure

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :quantity, presence: true

  def humanized_quantity
    sprintf("%g", quantity) + ' ' + measure.name
  end
end

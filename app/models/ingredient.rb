class Ingredient < ApplicationRecord
  belongs_to :recipe, inverse_of: :ingredients

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :quantity, presence: true
end

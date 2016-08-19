class Ingredient < ApplicationRecord
  belongs_to :recipe, inverse_of: :ingredients
  belongs_to :measure
  belongs_to :product

  validates :quantity, presence: true
  validates :product_id, uniqueness: { scope: :recipe_id, case_sensitive: true }

  before_validation :add_new_product, if: :new_product_name?

  attr_accessor :new_name

  def humanized_quantity
    sprintf("%g", quantity) + ' ' + measure.name
  end

  protected

  def new_product_name?
    !Product.exists?(self.product_id)
  end

  def add_new_product
    new_product = Product.new(name: self.new_name)
    if new_product.save
      self.product_id = new_product.id
    end
  end
end

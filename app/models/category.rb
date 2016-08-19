class Category < ApplicationRecord
  belongs_to :parent, class_name: 'Category', optional: true

  has_many :children, class_name: 'Category', foreign_key: 'parent_id'
  has_many :categorizations
  has_many :recipes, through: :categorizations

  def siblings
    if parent
      parent.children
    else
      Category.where parent: nil
    end
  end

  def parent_chain
    if parent
      parent.parent_chain << self
    else
      [self]
    end
  end

  def parent_chain_with_siblings
    result = {}
    parent_chain.each do |member|
      result[member] = member.siblings
    end
    result
  end

  def self.popular
    select("categories.*, count(recipes.id) AS recipes_count").
    joins(:recipes).
    group("categories.id").
    order("recipes_count DESC")
  end
end

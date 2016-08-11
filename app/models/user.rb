class User < ApplicationRecord
  default_scope { order(created_at: :desc) }

  has_many :recipes
  has_many :comments

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  has_attached_file :image,
                    styles: { medium: "960x640>", thumb: "240x240#" },
                    default_url: "/images/missing_avatar.jpg"

  def owner_of?(recipe)
    fail ArgumentError.new('You must pass a recipe.') unless recipe.kind_of? Recipe
    recipes.include?(recipe)
  end
end

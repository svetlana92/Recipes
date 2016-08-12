class Recipe < ApplicationRecord
  belongs_to :user
  has_many :categorizations
  has_many :categories, through: :categorizations
  has_many :comments
  has_many :ingredients, inverse_of: :recipe

  validates :name, presence: true, length: { minimum: 6, maximum: 100 }
  validates :description, presence: true, length: { minimum: 10, maximum: 500 }
  validates :user, presence: true
  validates :image, presence: true
  validates :categories, presence: true, length: { minimum: 1, maximum: 3 }
  # validates :ingredients, length: { minimum: 2 }

  has_attached_file :image,
                    styles: { medium: "960x640>", thumb: "480x320#" },
                    default_url: "/images/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  accepts_nested_attributes_for :ingredients,
                                allow_destroy: true,
                                reject_if: lambda { |attributes| attributes['name'].blank? }


  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      where(nil)
    end
  end

end

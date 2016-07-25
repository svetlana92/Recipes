class Recipe < ApplicationRecord
  belongs_to :user
  has_many :categorizations
  has_many :categories, through: :categorizations

  validates :name, presence: true, length: { minimum: 6 }
  validates :user, presence: true
  validates :categories, presence: true, length: { minimum: 1, maximum: 3 }

  has_attached_file :image,
                    styles: { medium: "960x640>", thumb: "480x320#" },
                    default_url: "/images/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end

class Recipe < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { minimum: 6 }
  validates :user, presence: true

  has_attached_file :image,
                    styles: { medium: "960x640>", thumb: "480x320#" },
                    default_url: "/images/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end

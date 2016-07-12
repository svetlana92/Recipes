class Recipe < ApplicationRecord
  has_attached_file :image,
                    styles: { medium: "960x640>", thumb: "480x320#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end

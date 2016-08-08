class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :recipes

  has_attached_file :image,
                    styles: { medium: "960x640>", thumb: "240x240#" },
                    default_url: "/images/missing_avatar.jpg"
end

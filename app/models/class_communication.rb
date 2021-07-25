class ClassCommunication < ApplicationRecord
  belongs_to :user
  has_many_attached :images
<<<<<<< HEAD
  has_many :likes, dependent: :destroy
=======
  has_many :likes
  has_many :tag_class_communications, dependent: :destroy
  has_many :tags, through: :tag_class_communications
>>>>>>> master
end

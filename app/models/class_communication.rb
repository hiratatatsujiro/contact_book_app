class ClassCommunication < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_many :likes
  has_many :tag_class_communications
  has_many :tags, through: :tag_class_communications
end

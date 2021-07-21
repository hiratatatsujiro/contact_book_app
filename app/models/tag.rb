class Tag < ApplicationRecord
  has_many :tag_class_communications
  has_many :class_communications, through: :tag_class_communications

  validates :tag_name, uniqueness: true
end

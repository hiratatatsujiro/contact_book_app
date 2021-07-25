class Diary < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :diary_tag_relations, dependent: :destroy
  has_many :tags, through: :diary_tag_relations
end

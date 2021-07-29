class Diary < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy

  with_options presence: true do
    validates :diary_day
    validates :title
    validates :diary
    validates :image
  end
end

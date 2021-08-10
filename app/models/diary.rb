class Diary < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy

  with_options presence: true do
    validates :diary_day
    validates :title
    validates :image
    validates :user_id
    validates :diary
  end
end

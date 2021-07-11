class Diary < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :diary_day
    validates :title
    validates :diary
    validates :image
  end
end

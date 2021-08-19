class Diary < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy

  with_options presence: true do
    validates :diary_day
    validates :title
    validates :image
    validates :diary
  end

  def self.search(search)
    if search != ""
      Diary.where('diary LIKE(?)', "%#{search}%")
    else
      Diary.includes(:user)
    end
  end
end

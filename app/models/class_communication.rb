class ClassCommunication < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :class_communication_day
    validates :title
    validates :text
    validates :image
  end
end

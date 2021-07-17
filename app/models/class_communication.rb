class ClassCommunication < ApplicationRecord
  belongs_to :user
  has_many_attached :images

  with_options presence: true do
    validates :class_communication_day
    validates :title
    validates :text
    validates :images
  end
end

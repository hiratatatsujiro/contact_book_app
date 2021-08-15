class ClassCommunication < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_many :likes, dependent: :destroy

  with_options presence: true do
    validates :class_communication_day
    validates :title
    validates :text
    validates :images
  end

  def self.search(search)
    if search != ""
      ClassCommunication.where('text LIKE(?)', "%#{search}%")
    else
      ClassCommunication.all
    end
  end
end

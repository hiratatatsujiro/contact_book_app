class Timetable < ApplicationRecord
  belongs_to :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :first_class
  belongs_to :second_class
  belongs_to :third_class
  belongs_to :fourth_class
  belongs_to :fifth_class
  belongs_to :sixth_class

  with_options presence: true do
    validates :next_day
    validates :homework
    validates :preparation
    validates :leave_time
  end

  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :first_class_id 
    validates :second_class_id
    validates :third_class_id
    validates :fourth_class_id
    validates :fifth_class_id
    validates :sixth_class_id
  end
end

class Timetable < ApplicationRecord
  belongs_to :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category

  with_options presence: true do
    validates :next_day
    validates :first_hour 
    validates :second_hour
    validates :third_hour
    validates :fourth_hour
    validates :fifth_hour
    validates :sixth_hour
    validates :homework
    validates :preparation
    validates :leave_time
  end
end

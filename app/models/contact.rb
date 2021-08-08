class Contact < ApplicationRecord
  belongs_to :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :condition
  belongs_to :pool_marathon
end

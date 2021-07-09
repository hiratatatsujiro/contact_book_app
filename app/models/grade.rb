class Grade < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '1年' },
    { id: 3, name: '2年' },
    { id: 4, name: '3年' },
    { id: 5, name: '4年' },
    { id: 6, name: '5年' },
    { id: 7, name: '6年' }
  ]

  include ActiveHash::Associations
  has_many :users
end

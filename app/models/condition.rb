class Condition < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: 'お休みします' },
    { id: 3, name: '遅刻します' },
    { id: 4, name: '早退します' },
    { id: 5, name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :contacts
end

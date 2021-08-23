class PoolMarathon < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: 'できます' },
    { id: 3, name: 'お休みします' },
    { id: 4, name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :contacts
end

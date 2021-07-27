class Number < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '1番' },
    { id: 3, name: '2番' },
    { id: 4, name: '3番' },
    { id: 5, name: '4番' },
    { id: 6, name: '5番' },
    { id: 7, name: '6番' },
    { id: 8, name: '7番' },
    { id: 9, name: '8番' },
    { id: 10, name: '9番' },
    { id: 11, name: '10番' },
    { id: 12, name: '11番' },
    { id: 13, name: '12番' },
    { id: 14, name: '13番' },
    { id: 15, name: '14番' },
    { id: 16, name: '15番' },
    { id: 17, name: '16番' },
    { id: 18, name: '17番' },
    { id: 19, name: '18番' },
    { id: 20, name: '19番' },
    { id: 21, name: '20番' },
    { id: 22, name: '21番' },
    { id: 23, name: '22番' },
    { id: 24, name: '23番' },
    { id: 25, name: '24番' },
    { id: 26, name: '25番' },
    { id: 27, name: '26番' },
    { id: 28, name: '27番' },
    { id: 29, name: '28番' },
    { id: 30, name: '29番' },
    { id: 31, name: '30番' },
    { id: 32, name: '31番' },
    { id: 33, name: '32番' },
    { id: 34, name: '33番' },
    { id: 35, name: '34番' },
    { id: 36, name: '35番' },
    { id: 37, name: '36番' },
    { id: 38, name: '37番' },
    { id: 39, name: '38番' },
    { id: 40, name: '39番' },
    { id: 41, name: '40番' },
    { id: 42, name: '41番' },
    { id: 43, name: '42番' },
    { id: 44, name: '43番' },
    { id: 45, name: '44番' },
    { id: 46, name: '45番' },
    { id: 47, name: '46番' },
    { id: 48, name: '47番' },
    { id: 49, name: '48番' },
    { id: 50, name: '49番' },
    { id: 51, name: '50番' },
    { id: 52, name: '先生' }
  ]

  include ActiveHash::Associations
  has_many :users
end

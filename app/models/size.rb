class Size < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '70cm' },
    { id: 3, name: '80cm' },
    { id: 4, name: '90cm' },
    { id: 5, name: '100cm' },
    { id: 6, name: '110cm' },
    { id: 7, name: '120cm' },
    { id: 8, name: '130cm' },
    { id: 9, name: '140cm' },
    { id: 10, name: '150cm' },
    { id: 11, name: 'S' },
    { id: 12, name: 'M' },
    { id: 13, name: 'L' },
    { id: 14, name: 'LL' },
    { id: 15, name: '12cm' },
    { id: 16, name: '12.5cm' },
    { id: 17, name: '13cm' },
    { id: 18, name: '13.5cm' },
    { id: 19, name: '14cm' },
    { id: 20, name: '14.5cm' },
    { id: 21, name: '15cm' },
    { id: 22, name: '15.5cm' },
    { id: 23, name: '16cm' },
    { id: 24, name: '16.5cm' },
    { id: 25, name: '17cm' },
    { id: 26, name: '17.5cm' },
    { id: 27, name: '18cm' },
    { id: 28, name: '18.5cm' },
    { id: 29, name: '19cm' },
    { id: 30, name: '19.5cm' },
    { id: 31, name: '20cm' },
    { id: 32, name: 'その他'}
  ]

  include ActiveHash::Associations
  has_many :items
end
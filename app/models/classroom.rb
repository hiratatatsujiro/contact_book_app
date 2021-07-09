class Classroom < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '1組' },
    { id: 3, name: '2組' },
    { id: 4, name: '3組' },
    { id: 5, name: '4組' },
    { id: 6, name: '5組' },
    { id: 7, name: '6組' },
    { id: 8, name: '7組' },
    { id: 9, name: '8組' },
    { id: 10, name: '9組' },
    { id: 11, name: '10組' },
    { id: 12, name: 'A組' },
    { id: 13, name: 'B組' },
    { id: 14, name: 'C組' },
    { id: 15, name: 'D組' },
    { id: 16, name: 'E組' },
    { id: 17, name: 'F組' },
    { id: 18, name: 'G組' },
    { id: 19, name: 'H組' },
    { id: 20, name: 'I組' },
    { id: 21, name: 'J組' },
    { id: 22, name: '特別支援1組' },
    { id: 23, name: '特別支援2組' },
    { id: 24, name: '特別支援3組' },
    { id: 25, name: '特別支援4組' },
    { id: 26, name: '特別支援5組' },
    { id: 27, name: '特別支援6組' },
    { id: 28, name: '特別支援7組' },
    { id: 29, name: '特別支援8組' },
    { id: 30, name: '特別支援9組' },
    { id: 31, name: '特別支援10組' }

  ]

  include ActiveHash::Associations
  has_many :users
end

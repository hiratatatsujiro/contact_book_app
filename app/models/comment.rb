class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :diary

<<<<<<< Updated upstream
  with_options presence: true do
    validates :comment
  end
=======
  validates :comment, presence: true
>>>>>>> Stashed changes
end

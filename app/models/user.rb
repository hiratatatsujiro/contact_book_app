class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :diaries
  has_many :comments

  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to :grade
    belongs_to :classroom
    belongs_to :number
       
with_options presence: true do
    validates :image
    validates :nickname
    validates :introduction
    validates :birthday
  with_options format: { with: /\A[ァ-ヶー－]+\z/, message: 'is invalid. Input full-width katakana characters.' } do
    validates :last_name_reading
    validates :first_name_reading
  end
       
   with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :grade_id
    validates :classroom_id
    validates :number_id
   end
       
   with_options format: { with: /\A[ぁ-んァ-ン一-龥々]+\z/, message: 'is invalid. Input full-width characters.' } do
     validates :last_name
     validates :first_name
    end
  end
    validates :password, on: :create, length: { minimum: 6 },
                         format: { with: /(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{6,}/, message: 'is invalid. Include both letters and numbers' }
    mount_uploader :image, ImageUploader
       
    def update_with_password(params, *options)
      current_password = params.delete(:current_password)
       
      if params[:password].blank?
        params.delete(:password)
        params.delete(:password_confirmation) if params[:password_confirmation].blank?
      end
       
     result = if params[:password].blank? || valid_password?(current_password)
        update_attributes(params, *options)
        else
        assign_attributes(params, *options)
            valid?
            errors.add(:current_password, current_password.blank? ? :blank : :invalid)
            false
         end
       
           clean_up_passwords
           result
         end
       
         def password_presence
           return if password.present?
       
           errors.add(:base, '')
         end
end

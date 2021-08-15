class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :diaries
  has_many :comments
  has_many :room_users
  has_many :rooms, through: :room_users
  has_many :chat_messages
  has_many :items
  has_one_attached :image
  has_many :class_communications
  has_many :likes
  has_many :timetables
  has_many :contacts
  has_many :item_comments

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :grade
  belongs_to :classroom
  belongs_to :number

  with_options presence: true do
    validates :image
    validates :nickname
    validates :introduction
    validates :birthday
    with_options format: { with: /\A[ァ-ヶー－]+\z/, message: 'に誤りがあります。全角カタカナで入力してください' } do
      validates :last_name_reading
      validates :first_name_reading
    end

    with_options numericality: { other_than: 1, message: "を選択して下さい" } do
      validates :grade_id
      validates :classroom_id
      validates :number_id
    end

    with_options format: { with: /\A[ぁ-んァ-ン一-龥々]+\z/, message: 'に誤りがあります。全角で入力してください' } do
      validates :last_name
      validates :first_name
    end
  end
  validates :password, on: :create, length: { minimum: 6 },
                       format: { with: /(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{6,}/, message: 'に誤りがあります。文字と数字の両方を含める必要があります' }

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

  def liked_by?(class_communication_id)
    likes.where(class_communication_id: class_communication_id).exists?
  end
end

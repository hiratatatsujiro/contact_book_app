class OrderInformation
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :token, :postal_code, :delivery_area_id, :city, :house_number, :building, :phone_number

  with_options presence: true do
    validates :token
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'に誤りがあります。次のように入力してください (例 123-4567)' }
  end
  validates :delivery_area_id, numericality: { other_than: 1, message: "を選択してください" }
  with_options presence: true do
    validates :city
    validates :house_number
    validates :phone_number, length: { minimum: 10, message: 'が短すぎます' }
  end
  validates :phone_number, length: { maximum: 11, message: 'が長すぎます' }
  validates :phone_number, format: { with: /\A[0-9]+\z/, message: 'に誤りがあります。数字のみで入力してください' }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Information.create(postal_code: postal_code, delivery_area_id: delivery_area_id, city: city,
                       house_number: house_number, building: building, phone_number: phone_number, order_id: order.id)
  end
end

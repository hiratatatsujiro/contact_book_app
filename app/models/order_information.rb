class OrderInformation
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :token, :postal_code, :delivery_area_id, :city, :house_number, :building, :phone_number

  with_options presence: true do
    validates :token
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
  end
  validates :delivery_area_id, numericality: { other_than: 1, message: "can't be blank" }
  with_options presence: true do
    validates :city
    validates :house_number
    validates :phone_number, length: { minimum: 10, message: 'is too short' }
  end
  validates :phone_number, length: { maximum: 11, message: 'is too long' }
  validates :phone_number, format: { with: /\A[0-9]+\z/, message: 'is invalid. Input only number' }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Information.create(postal_code: postal_code, delivery_area_id: delivery_area_id, city: city,
                       house_number: house_number, building: building, phone_number: phone_number, order_id: order.id)
  end
end

class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :item_params, only: [:index, :create]
  before_action :move_to_index, only: :index

  def index
    @order_information = OrderInformation.new
  end

  def create
    @order_information = OrderInformation.new(order_params)
    if @order_information.valid?
      pay_item
      @order_information.save
      redirect_to items_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_information).permit(:postal_code, :delivery_area_id, :city, :house_number, :building, :phone_number).merge(
      user_id: current_user.id, item_id: @item.id, token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: params[:token],
      currency: 'jpy'
    )
  end

  def move_to_index
    redirect_to items_path if @item.order.present? || @item.user_id == current_user.id
  end

  def item_params
    @item = Item.find(params[:item_id])
  end
end

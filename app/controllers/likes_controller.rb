class LikesController < ApplicationController
  before_action :class_communication_params
  def create
    Like.create(user_id: current_user.id, class_communication_id: params[:id])
  end

  def destroy
    Like.find_by(user_id: current_user.id, class_communication_id: params[:id]).destroy
  end

  def class_communication_params
    @class_communication = ClassCommunication.find(params[:id])
  end
end

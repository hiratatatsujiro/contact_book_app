class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to root_path      
    end
  end
end

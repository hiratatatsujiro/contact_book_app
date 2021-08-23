class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
<<<<<<< Updated upstream
=======
    redirect_to root_path unless @user.id == current_user.id
>>>>>>> Stashed changes
  end
end

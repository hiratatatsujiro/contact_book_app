class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameter, if: :devise_controller?

  def configure_permitted_parameter
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:nickname, :last_name, :first_name, :last_name_reading, :first_name_reading,
                                             :birthday, :introduction, :grade_id, :classroom_id, :number_id, :image])

    devise_parameter_sanitizer.permit(:account_update,
                                      keys: [:nickname, :last_name, :first_name, :last_name_reading, :first_name_reading,
                                             :birthday, :introduction, :grade_id, :classroom_id, :number_id, :image])
  end
end

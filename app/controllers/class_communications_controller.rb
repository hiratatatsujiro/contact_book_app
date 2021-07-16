class ClassCommunicationsController < ApplicationController
  def index
    @class_communications = ClassCommunication.all
  end

  def new
    @class_communication = ClassCommunication.new
  end

  def create
    @class_communication = ClassCommunication.new(class_communication_params)
    if @class_communication.save
      redirect_to class_communications_path
    else
      render :new
    end
  end

  def show
    
  end

  def edit
    
  end

  def update
    
  end

  def destroy
    
  end

  private
  def class_communication_params
    params.require(:class_communication).permit(:class_communication_day, :title, :text, :image).merge(user_id: current_user.id)
  end
end

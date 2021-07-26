class ClassCommunicationsController < ApplicationController
  def index
    @class_communications = ClassCommunication.all
  end

  def new
    @class_communication = ClassCommunication.new
  end

  def create
    @class_communication = ClassCommunication.new(class_communication_params)
    if @class_communication.valid?
      @class_communication.save
      redirect_to class_communications_path
    else
      render :new
    end
  end

  def show
    @class_communication = ClassCommunication.find(params[:id])
  end

  def edit
    @class_communication = ClassCommunication.find(params[:id])
  end

  def update
    @class_communication = ClassCommunication.find(params[:id])
    @class_communication.update(class_communication_params)
    if @class_communication.save
      redirect_to class_communications_path
    else
      render :edit
    end
  end

  def destroy
    @class_communication = ClassCommunication.find(params[:id])
    @class_communication.destroy
    redirect_to class_communications_path
  end

  private

  def class_communication_params
    params.require(:class_communication).permit(:class_communication_day, :title, :text,
                                                images: []).merge(user_id: current_user.id)
  end
end

class ClassCommunicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_class_communication_params, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, except: [:index, :show, :search]

  def index
    @class_communications = ClassCommunication.all.order("created_at DESC")
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
  end

  def search
    @class_communications = ClassCommunication.search(params[:keyword])
  end

  def edit
  end

  def update  
    @class_communication.update(class_communication_params)
    if @class_communication.valid? 
      redirect_to class_communications_path
    else
      render :edit
    end
  end

  def destroy 
    @class_communication.destroy
    redirect_to class_communications_path
  end

  private

  def class_communication_params
    params.require(:class_communication).permit(:class_communication_day, :title, :text,
                                                images: []).merge(user_id: current_user.id)
  end

  def find_class_communication_params
    @class_communication = ClassCommunication.find(params[:id])
  end

  def move_to_index
    unless current_user.number_id == 52 
      redirect_to class_communications_path
    end 
  end
  
end

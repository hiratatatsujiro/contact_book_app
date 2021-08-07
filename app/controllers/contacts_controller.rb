class ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_params, only: [:edit, :update, :show, :destroy]

  def index
    @contacts = Contact.all
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.valid?
      @contact.save
      redirect_to contacts_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @contact.valid?
      @contact.update(contact_params)
      redirect_to contacts_path
    else
      render :edit
    end
  end

  def destroy 
    @contact.destroy
    redirect_to contacts_path
  end


  private
  def contact_params
    params.require(:contact).permit(:condition_id, :reason, :pool_marathon_id, :contact).merge(user_id: current_user.id)   
  end

  def find_params
    @contact = Contact.find(params[:id])
  end
end
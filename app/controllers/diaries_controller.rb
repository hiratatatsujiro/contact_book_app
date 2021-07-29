class DiariesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_diary_params, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:show, :edit, :update, :delete]
  
  def index
    @diaries = Diary.all
  end

  def new
    @diary = Diary.new
  end

  def create
    @diary = Diary.new(diary_params)
    if @diary.valid?
      @diary.save
      redirect_to diaries_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new 
    @comments = @diary.comments
  end

  def edit  
  end

  def update
    if @diary.valid?
      @diary.update(diary_params)
      redirect_to diaries_path
    else
      render :edit
    end
  end

  def destroy
    @diary.destroy
    redirect_to root_path
  end

  private

  def diary_params
    params.require(:diary).permit(:diary_day, :title, :diary, :image).merge(user_id: current_user.id)
  end

  def find_diary_params
    @diary = Diary.find(params[:id])
  end

  def move_to_index
    unless @diary.user_id == current_user.id
      redirect_to diaries_path
    end
  end
end

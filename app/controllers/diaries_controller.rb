class DiariesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_diary_params, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:show, :edit, :update, :delete]
  
  def index
    @diaries = Diary.includes(:user).order("created_at DESC")
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
    @comments = @diary.comments.includes(:user)
  end

  def search
    @diaries = Diary.search(params[:keyword])
  end

  def edit  
  end

  def update
    @diary.update(diary_params)
    if @diary.valid?
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
    unless @diary.user_id == current_user.id || (@diary.user.grade_id == current_user.grade_id && @diary.user.classroom_id == current_user.classroom_id && current_user.number_id == 52)
      redirect_to diaries_path
    end
  end
end

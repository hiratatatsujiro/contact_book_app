class DiariesController < ApplicationController
  require "date"
  def index
    @diaries - Diary.all.order(created_at: :desc)
  end

  def new
    @diary = Diary.new
  end

  def create
    @diary = Diary.new(diary_params)
    #binding.pry
    if @diary.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def diary_params
    params.require(:diary).permit(:diary_day, :title, :diary, :image).merge(user_id: current_user.id)
  end
end

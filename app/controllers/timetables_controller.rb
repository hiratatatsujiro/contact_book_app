class TimetablesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_params, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:show, :edit, :update, :destroy]

  def index
    @timetables = Timetable.all.order(created_at: :desc).limit(5)
  end

  def new
    @timetable = Timetable.new
  end

  def create
    @timetable = Timetable.new(timetable_params)
    if @timetable.valid?
      @timetable.save
      redirect_to timetables_path
    else
      render "new"
    end
  end

  def show
  end

  def edit 
  end

  def update
    @timetable.update(timetable_params)
    if @timetable.valid?
      redirect_to timetable_path(@timetable)
    else
      render "edit"
    end
  end

  def destroy
    @timetable.destroy
    redirect_to timetables_path
  end

  private
  def timetable_params
    params.require(:timetable).permit(:next_day, :first_class_id, :second_class_id, :third_class_id, :fourth_class_id, :fifth_class_id, :sixth_class_id, :leave_time, :homework, :preparation, :notice).merge(user_id: current_user.id)
  end

  def find_params
    @timetable = Timetable.find(params[:id])
  end

  def move_to_index
    unless @timetable.user.grade_id == current_user.grade_id && @timetable.user.classroom_id == current_user.classroom_id
      redirect_to timetables_path
    end
  end
end

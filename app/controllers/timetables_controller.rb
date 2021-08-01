class TimetablesController < ApplicationController
  before_action :authenticate_user!
  def index
    @timetables = Timetable.all.order(created_at: :desc)
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
    @timetable = Timetable.find(params[:id])
    @timetables = Timetable.all
  end

  def edit
    @timetable = Timetable.find(params[:id])
  end

  def update
    @timetable = Timetable.find(params[:id])
    if @timetable.valid?
      @timetable.update(timetable_params)
      redirect_to timetable_path(@timetable)
    else
      render "edit"
    end
  end

  def destroy
    @timetable = Timetable.find(params[:id])
    @timetable.destroy
    redirect_to timetables_path
  end

  private
  def timetable_params
    params.require(:timetable).permit(:next_day, :first_class_id, :second_class_id, :third_class_id, :fourth_class_id, :fifth_class_id, :sixth_class_id, :leave_time, :homework, :preparation, :notice).merge(user_id: current_user.id)
  end
end

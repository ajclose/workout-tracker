class WorkoutsController < ApplicationController
  before_action :logged_in_user
  before_action :set_workout, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]

  def index
    @workouts = Workout.all
  end

  def new
    @workout = Workout.new
  end

  def create
    @workout = Workout.create(workout_params)
    if @workout.save
      flash[:success] = "Workout created"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @workout.update_attributes(workout_params)
      flash[:success] = "Workout updated"
      redirect_to @workout
    else
      render 'edit'
    end
  end

  def destroy
    @workout.destroy
    flash[:success] = "Workout successfully deleted"
    redirect_to root_path
  end

  private

  def workout_params
    params.require(:workout).permit(:date, :tracked).merge(user_id: current_user.id)
  end

  def set_workout
    @workout = Workout.find(params[:id])
  end

  def correct_user
    if current_user.id != @workout.user_id
      redirect_to root_path
    end
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please login"
      redirect_to login_path
    end
  end
end

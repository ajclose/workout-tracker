class AmrapsController < ApplicationController
  before_action :logged_in_user
  before_action :set_workout
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  before_action :set_amrap, only: [:edit, :update, :destroy]

  def new
    @amrap = Amrap.new
  end

  def create
    @amrap = Amrap.create(amrap_params)
    if @amrap.save
      flash[:success] = "Workout updated"
      redirect_to edit_workout_amrap_path(@workout, @amrap)
    else
      flash[:alert] = "error"
      render "new"
    end
  end

  def edit
  end

  def update
    @amrap.update_attributes(amrap_params)
    if @amrap.save
      flash[:success] = "Workout updated"
      redirect_to edit_workout_amrap_path(@workout, @amrap)
    else
      render "edit"
    end
  end

  def destroy
    @amrap.destroy
    flash[:success] = "AMRAP deleted"
    redirect_to edit_workout_path(@workout)
  end

  private

  def amrap_params
    params.require(:amrap).permit(:time, :score, :additional_reps, :notes, :name).merge(workout_id: params[:workout_id])
  end

  def set_workout
    @workout = Workout.find(params[:workout_id])
  end

  def set_amrap
    @amrap = Amrap.find(params[:id])
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

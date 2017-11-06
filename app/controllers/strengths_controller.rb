class StrengthsController < ApplicationController
  before_action :logged_in_user
  before_action :set_workout
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  before_action :set_strength, only: [:edit, :update, :destroy]

  def new
    @strength = Strength.new
  end

  def create
    @strength = Strength.create(strength_params)
    if @strength.save
      flash[:success] = "Workout updated"
      redirect_to edit_workout_strength_path(@workout, @strength)
    else
      flash[:alert] = "error"
      render "new"
    end
  end

  def edit
  end

  def update
    @strength.update_attributes(strength_params)
    if @strength.save
      flash[:success] = "Workout updated"
      redirect_to edit_workout_strength_path(@workout, @strength)
    else
      render "edit"
    end
  end

  def destroy
    @strength.destroy
    flash[:success] = "Strength deleted"
    redirect_to edit_workout_path(@workout)
  end

  private

  def strength_params
    params.require(:strength).permit(:movement, :reps, :sets, :weight, :notes).merge(workout_id: params[:workout_id])
  end

  def set_workout
    @workout = Workout.find(params[:workout_id])
  end

  def set_strength
    @strength = Strength.find(params[:id])
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

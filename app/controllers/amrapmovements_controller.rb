class AmrapmovementsController < ApplicationController
  before_action :logged_in_user
  before_action :set_amrap
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  before_action :set_amrapmovement, only: [:edit, :update, :destroy]

  def new
    @amrapmovement = Amrapmovement.new
  end

  def create
    @amrapmovement = Amrapmovement.create(amrapmovement_params)
    if @amrapmovement.save
      flash[:success] = "Movement added"
      redirect_to edit_workout_amrap_path(@amrap.workout_id, @amrap)
    else
      render "new"
    end
  end

  def edit
  end

  def update
    @amrapmovement.update_attributes(amrapmovement_params)
    if @amrapmovement.save
      flash[:success] = "Movement updated"
      redirect_to edit_workout_amrap_path(@amrap.workout_id, @amrap)
    else
      render "edit"
    end
  end

  def destroy
    @amrapmovement.destroy
    flash[:success] = "Movement deleted"
    redirect_to edit_workout_path(@amrap.workout_id)
  end

  private

  def amrapmovement_params
    params.require(:amrapmovement).permit(:rx_movement, :rx_reps, :rx_weight, :rx_unit, :scaled_movement, :scaled_reps, :scaled_weight, :scaled_unit).merge(amrap_id: params[:amrap_id])
  end

  def set_amrap
    @amrap = Amrap.find(params[:amrap_id])
  end

  def set_amrapmovement
    @amrapmovement = Amrapmovement.find(params[:id])
  end

  def correct_user
    if current_user.id != @amrap.workout.user_id
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

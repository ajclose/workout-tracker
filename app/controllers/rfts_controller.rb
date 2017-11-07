class RftsController < ApplicationController
  before_action :logged_in_user
  before_action :set_workout
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  before_action :set_rft, only: [:edit, :update, :destroy]

  def new
    @rft = Rft.new
  end

  def create
    @rft = Rft.create(rft_params)
    if @rft.save
      flash[:success] = "Workout updated"
      redirect_to edit_workout_rft_path(@workout, @rft)
    else
      flash[:alert] = "error"
      render "new"
    end
  end

  def edit
  end

  def update
    @rft.update_attributes(rft_params)
    if @rft.save
      flash[:success] = "Workout updated"
      redirect_to edit_workout_rft_path(@workout, @rft)
    else
      render "edit"
    end
  end

  def destroy
    @rft.destroy
    flash[:success] = "RFT deleted"
    redirect_to edit_workout_path(@workout)
  end

  private

  def rft_params
    params.require(:rft).permit(:rounds, :score, :notes, :name).merge(workout_id: params[:workout_id])
  end

  def set_workout
    @workout = Workout.find(params[:workout_id])
  end

  def set_rft
    @rft = Rft.find(params[:id])
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

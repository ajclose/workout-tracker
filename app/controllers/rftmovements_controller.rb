class RftmovementsController < ApplicationController
  before_action :logged_in_user
  before_action :set_rft
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  before_action :set_rftmovement, only: [:edit, :update, :destroy]

  def new
    @rftmovement = Rftmovement.new
  end

  def create
    @rftmovement = Rftmovement.create(rftmovement_params)
    if @rftmovement.save
      flash[:success] = "Movement added"
      redirect_to edit_workout_rft_path(@rft.workout_id, @rft)
    else
      flash[:alert] = "error"
      render "new"
    end
  end

  def edit
  end

  def update
    @rftmovement.update_attributes(rftmovement_params)
    if @rftmovement.save
      flash[:success] = "Movement updated"
      redirect_to edit_workout_rft_path(@rft.workout_id, @rft)
    else
      render "edit"
    end
  end

  def destroy
    @rftmovement.destroy
    flash[:success] = "Movement deleted"
    redirect_to edit_workout_path(@rft.workout_id)
  end

  private

  def rftmovement_params
    params.require(:rftmovement).permit(:rx_movement, :rx_reps, :rx_weight, :rx_unit, :scaled_movement, :scaled_reps, :scaled_weight, :scaled_unit).merge(rft_id: params[:rft_id])
  end

  def set_rft
    @rft = Rft.find(params[:rft_id])
  end

  def set_rftmovement
    @rftmovement = Rftmovement.find(params[:id])
  end

  def correct_user
    if current_user.id != @rft.workout.user_id
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

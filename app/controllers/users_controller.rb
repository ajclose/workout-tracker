class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create, :index]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index

  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account"
      redirect_to login_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to root_path
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please login"
        redirect_to login_path
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user)
    end

    def admin_user
      redirect_to root_path unless current_user.admin?
    end

end

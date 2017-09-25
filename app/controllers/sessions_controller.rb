class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      if user.activated?
        log_in user
        params[:remember_me] == '1' ? remember(user) : forget(user)
        redirect_to root_path
      else
        message = "Account not activated.  Check your email for activation link"
        flash[:warning] = message
        redirect_to login_path
      end
    else
      flash.now[:danger] = 'Email or password is not correct'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_path
  end
end

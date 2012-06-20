class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to viewings_path
    else
      redirect_to log_in_path, :alert => "Invalid email or password"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end

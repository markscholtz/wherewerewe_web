class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(params[:user])

    if user.save
      session[:user_id] = user.id
      redirect_to viewings_path, :notice => "Account successfully created for #{user.email}"
    else
      redirect_to sign_up_path, :alert => 'Invalid email or password'
    end
  end
end

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      redirect_to viewings_path, :notice => "Account successfully created for #{@user.email}"
    else
      redirect_to register_path, :alert => 'Invalid email or password'
    end
  end
end

class ViewingsController < ApplicationController
  def index
    @user = User.first
  end
end

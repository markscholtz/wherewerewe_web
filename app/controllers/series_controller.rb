class SeriesController < ApplicationController
  def index
    @user = User.first
  end
end

class SeriesController < ApplicationController
  def index
    @user = User.first
    @series = Series.order("name")
  end
end

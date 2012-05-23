class SeriesController < ApplicationController
  def index
    @current_user = User.first
    @series = Series.order("name")
  end

  def show
    @series = Series.find params[:id]
  end
end

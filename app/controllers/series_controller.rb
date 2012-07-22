class SeriesController < ApplicationController
  def index
    @series = Series.order("name")
  end

  def show
    @series = Series.find params[:id]
  end
end

class SeriesController < ApplicationController
  def index
    @series = Series.order("name")
  end
end

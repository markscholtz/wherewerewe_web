class SeriesController < ApplicationController
  def index
    @all_series = Series.all
  end
end

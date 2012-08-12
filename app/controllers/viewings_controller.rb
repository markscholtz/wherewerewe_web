class ViewingsController < ApplicationController
  def index
    @progressions = current_user.progressions if current_user
  end

  def create
    series = Series.find(params[:series_id])
    Viewing.create_with_series_for_user(series.id, current_user.id)

    redirect_to series_index_path, :notice => "#{series.name} has been added to your viewing list"
  end

  def update
    viewing = Viewing.find(params[:id])
    viewing.viewed_at = Time.now
    viewing.save!
    redirect_to viewings_path
  end
end

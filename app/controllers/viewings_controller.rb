class ViewingsController < ApplicationController
  def index
    @series = current_user.series if current_user
  end

  def create
    user = User.first
    series = Series.find(params[:series_id])
    Viewing.create_with_series_for_user(series.id, user.id)

    redirect_to series_index_path, :notice => "#{series.name} has been added to your viewing list"
  end

  def update
    @user = User.first
    viewing = Viewing.find(params[:id])
    viewing.viewed_at = Time.now
    viewing.save!
    redirect_to viewings_path
  end
end

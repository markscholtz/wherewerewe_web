class ViewingsController < ApplicationController
  def index
    @user = User.first
  end

  def create
    user = User.first
    series = Series.find(params[:series_id])
    Viewing.create_with_series_for_user(series.id, user.id)

    redirect_to series_index_path, :notice => "#{series.name} has been added to your viewing list"
  end
end

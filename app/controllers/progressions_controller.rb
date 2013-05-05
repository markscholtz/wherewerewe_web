class ProgressionsController < ApplicationController
  def index
    unless current_user
      redirect_to root_path, alert: "Please log in" and return
    end

    @progressions = Progression.create_progressions(current_user, current_user.series)
  end
end

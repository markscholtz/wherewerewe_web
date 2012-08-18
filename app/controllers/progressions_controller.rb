class ProgressionsController < ApplicationController
  def index
    unless current_user
      raise CanCan::AccessDenied
    end

    @progressions = current_user.progressions if current_user
  end
end

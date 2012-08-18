class ProgressionsController < ApplicationController
  load_and_authorize_resource

  def index
    unless current_user
      raise CanCan::AccessDenied
    end
  end
end

class ProgressionsController < ApplicationController
  def index
    @progressions = current_user.progressions if current_user
    # authorize! :manage, @progressions
  end
end

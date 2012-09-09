class Progression
  include ActiveModel::Validations

  attr_accessor :user, :series

  validates_presence_of :user, :series

  def initialize(user = nil, series = nil)
    @user = user
    @series = series
  end

  def self.create_progressions(user, series)
    series.inject([]) do |memo, s|
      memo << new(user, s)
    end
  end

  # This will be called by CanCan on the index action when populating the @progressions ivar
  def self.accessible_by(ability, action = :index)
    create_progressions(ability.user, ability.user.series)
  end

  def user_id
    user.id
  end

  def series_name
    series.name
  end

  def series_overview
    series.overview
  end

  def series_viewed?
    series.viewed? user.id
  end

  def last_viewing
    user.last_viewing(series.id)
  end

  def last_viewing_season_number
    last_viewing.season.number
  end

  def last_viewing_episode_name
    last_viewing.episode.name
  end

  def last_viewing_episode_overview
    last_viewing.episode.overview
  end

  def next_viewing
    user.next_viewing(series.id)
  end

  def next_viewing_season_number
    next_viewing.season.number
  end

  def next_viewing_episode_name
    next_viewing.episode.name
  end

  def next_viewing_episode_overview
    next_viewing.episode.overview
  end
end

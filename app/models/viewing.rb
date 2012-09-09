class Viewing < ActiveRecord::Base
  validates_presence_of :episode_id, :season_id, :series_id, :user_id

  belongs_to :episode
  belongs_to :season
  belongs_to :series
  belongs_to :user

  def self.create_with_series_for_user(series_id, user_id)
    series = Series.find(series_id)
    user = User.find(user_id)
    series.episodes.each do |e|
      create_with_episode_for_user(e, user)
    end
  end

  private

  def self.create_with_episode_for_user(episode, user)
    viewing = Viewing.new
    viewing.user = user
    viewing.series = episode.series
    viewing.season = episode.season
    viewing.episode = episode
    viewing.save!
  end

  public

  def self.last_viewed(filter_ids)
    where_string = 'viewed_at IS NOT NULL and seasons.number != 0'
    filter_ids.each_pair do |key, value|
      if key.to_s == 'series_id'
        where_string << " and viewings.#{key} = #{value}"
      else
        where_string << " and #{key} = #{value}"
      end
    end

    joins(:season).
    where(where_string).
    order('viewed_at DESC').
    limit(1).
    first
  end

  def self.next(user_id, series_id)
    joins(:season).
    joins(:episode).
    where(:viewed_at => nil, :user_id => user_id, :series_id => series_id).
    where('seasons.number != 0').
    order('seasons.number, episodes.number').
    limit(1).
    first
  end

  def self.viewings_exist(filter_ids)
    where_string = ''
    filter_ids.each_pair do |key, value|
      where_string << "#{key} = #{value} and "
    end
    where_string = where_string[0, where_string.length - 5]

    where(where_string).any?
  end

  def to_s
    <<-EOS
----> User: #{user.email}
      Series: #{series.name}
      Season: #{season.number}
      Episode: #{episode.number} - #{episode.name}
      EOS
  end
end

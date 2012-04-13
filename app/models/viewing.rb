class Viewing < ActiveRecord::Base
  validates_presence_of :episode_id, :season_id, :series_id, :user_id

  belongs_to :episode
  belongs_to :season
  belongs_to :series
  belongs_to :user

  scope :last, lambda { |filter_ids|
    where_string = 'viewed_at IS NOT NULL'
    filter_ids.each_with_index do |filter_id, index|
      where_string << " and #{filter_id[0]} = #{filter_id[1]}"
    end

    where(where_string).
    order('viewed_at DESC')
  }

  scope :next, lambda { |user_id, series_id|
    joins(:season).
    joins(:episode).
    where(:viewed_at => nil, :user_id => user_id, :series_id => series_id).
    order('seasons.number, episodes.number').
    limit(1)
  }
end

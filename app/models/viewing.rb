class Viewing < ActiveRecord::Base
  validates_presence_of :episode_id, :user_id

  belongs_to :episode
  belongs_to :user
end

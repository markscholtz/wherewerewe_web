class Series < ActiveRecord::Base
  validates_presence_of :tvdb_id, :name, :overview, :last_updated
  validates_uniqueness_of :tvdb_id

  has_many :seasons
  has_many :episodes
  has_many :viewings, :dependent => :destroy
  has_many :users, :through => :viewings

  scope :viewed_by_user, lambda { |user_id|
    joins(:viewings).
    where('viewed_at IS NOT NULL and user_id = ?', user_id)
  }

  def viewed?(user_id)
    Series.viewed_by_user(user_id).include?(self)
  end
end

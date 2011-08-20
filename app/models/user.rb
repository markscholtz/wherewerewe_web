class User < ActiveRecord::Base
  validates_presence_of :email
  validates_uniqueness_of :email

  has_many :viewings, :dependent => :destroy
  has_many :episodes, :through => :viewings, :uniq => true
  has_many :series, :through => :viewings, :uniq => true

  def last_viewed(series_id)
    viewings.where('series_id = ?', series_id)
            .order('viewed_at DESC').first
  end
end

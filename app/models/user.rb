class User < ActiveRecord::Base
  attr_accessor :password

  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password

  has_many :viewings, :dependent => :destroy
  has_many :episodes, :through => :viewings, :uniq => true
  has_many :series, :through => :viewings, :uniq => true

  def last_viewing(series_id)
    Viewing.last_viewed user_id: id, series_id: series_id
  end

  def next_viewing(series_id)
    Viewing.next(id, series_id)
  end
end

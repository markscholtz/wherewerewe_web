class User < ActiveRecord::Base
  validates_presence_of :email
  validates_uniqueness_of :email

  has_many :viewings, :dependent => :destroy
  has_many :episodes, :through => :viewings, :uniq => true
  has_many :series, :through => :viewings, :uniq => true
end

class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation

  attr_accessor :password
  before_save :encrypt_password

  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :password, :password_confirmation, :on => :create
  validates_confirmation_of :password

  has_many :viewings, :dependent => :destroy
  has_many :episodes, :through => :viewings, :uniq => true
  has_many :series, :through => :viewings, :uniq => true

  def self.authenticate(email, password)
    user = find_by_email email
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def progressions
    Progression.create_progressions self, series
  end

  def last_viewing(series_id)
    Viewing.last_viewed user_id: id, series_id: series_id
  end

  def next_viewing(series_id)
    Viewing.next(id, series_id)
  end
end

class Season < ActiveRecord::Base
  validates_presence_of :tvdb_id, :number, :series
  validates_uniqueness_of :tvdb_id

  belongs_to :series
  has_many :episodes
end

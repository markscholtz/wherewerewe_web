class Season < ActiveRecord::Base
  validates_presence_of :tvdb_id, :number, :series_id
  validates_uniqueness_of :tvdb_id
  validates_uniqueness_of :number, :scope => :series_id

  belongs_to :series
  has_many :episodes
end

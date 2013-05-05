class Season < ActiveRecord::Base
  validates_presence_of :number, :series_id
  validates_uniqueness_of :number, :scope => :series_id

  belongs_to :series
  has_many :episodes, :dependent => :destroy
end

class Series < ActiveRecord::Base
  validates_presence_of :tvdb_id, :name, :overview, :last_updated
end

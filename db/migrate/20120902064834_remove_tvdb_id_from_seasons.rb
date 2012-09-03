class RemoveTvdbIdFromSeasons < ActiveRecord::Migration
  def change
    remove_column :seasons, :tvdb_id
  end
end

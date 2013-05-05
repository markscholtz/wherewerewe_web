class CreateEpisodes < ActiveRecord::Migration
  def self.up
    create_table :episodes do |t|
      t.integer :tvdb_id, :null => false
      t.string :name, :null => false
      t.string :overview, :null => false
      t.datetime :last_updated, :null => false
      t.integer :series_id, :null => false
      t.integer :season_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :episodes
  end
end

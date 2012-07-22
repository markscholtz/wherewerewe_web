class AddSeasonToViewings < ActiveRecord::Migration
  def self.up
    add_column :viewings, :season_id, :integer
  end

  def self.down
    remove_column :viewings, :season_id
  end
end

class CreateSeasons < ActiveRecord::Migration
  def self.up
    create_table :seasons do |t|
      t.integer :tvdb_id, :null => false
      t.integer :number, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :seasons
  end
end

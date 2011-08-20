class CreateViewings < ActiveRecord::Migration
  def self.up
    create_table :viewings do |t|
      t.integer :episode_id, :null => false
      t.integer :series_id, :null => false
      t.integer :user_id, :null => false
      t.datetime :viewed_at

      t.timestamps
    end
  end

  def self.down
    drop_table :viewings
  end
end

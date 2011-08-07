class CreateSeries < ActiveRecord::Migration
  def self.up
    create_table :series do |t|
      t.integer :id
      t.integer :tvdb_id
      t.string :name
      t.string :overview
      t.datetime :last_updated

      t.timestamps
    end
  end

  def self.down
    drop_table :series
  end
end

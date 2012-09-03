class ChangeOverviewColumnsToText < ActiveRecord::Migration
  def self.up
   change_column :series, :overview, :text
   change_column :episodes, :overview, :text
  end

  def self.down
   change_column :series, :overview, :string
   change_column :episodes, :overview, :string
  end
end

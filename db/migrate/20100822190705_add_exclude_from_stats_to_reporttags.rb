class AddExcludeFromStatsToReporttags < ActiveRecord::Migration
  def self.up
    add_column :reporttags, :exclude_from_stats, :integer, :null => false, :default => 0
  end

  def self.down
    remove_column :reporttags, :exclude_from_stats
  end
end

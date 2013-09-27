class FixAlertsTable < ActiveRecord::Migration
  def self.up
    add_column :alerts, :host_id, :integer
  end

  def self.down
  end
end

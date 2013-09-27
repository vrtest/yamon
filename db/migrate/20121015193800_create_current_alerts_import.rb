class CreateCurrentAlertsImport < ActiveRecord::Migration
  def self.up
    create_table :current_alerts_import do |t|
      t.string :hostname
      t.string :description
      t.integer :check_status
      t.integer :check_date
      t.string :service_output
      t.string :service_perfdata

      t.timestamps
    end
  end

  def self.down
    drop_table :current_alerts_import
  end
end

class CreateAlerts < ActiveRecord::Migration
  def self.up
    create_table :alerts do |t|
      t.datetime    :date_start,    :null => false
      t.datetime    :date_end,      :null => false
      t.integer     :check_status,  :null => false
      t.string      :service_output
      t.string      :service_perfdata
      t.integer     :duration,      :null => false
      t.references  :service, :report
      t.timestamps
    end
  end

  def self.down
    drop_table :alerts
  end
end

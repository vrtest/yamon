class AddNotificationDelayToHosts < ActiveRecord::Migration
  def change
    add_column :hosts, :notification_delay, :integer, null: true

  end
end

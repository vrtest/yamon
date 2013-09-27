class AddNotificationDelayToServices < ActiveRecord::Migration
  def change
    add_column :services, :notification_delay, :integer, null: true

  end
end

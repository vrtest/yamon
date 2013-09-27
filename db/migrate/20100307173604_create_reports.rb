class CreateReports < ActiveRecord::Migration
  def self.up
    create_table :reports do |t|
      t.string :label, :null => false
      t.string :description
      t.datetime :estimated_date
      t.integer :select_priority, :null => false, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :reports
  end
end

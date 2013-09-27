class CreateServicetags < ActiveRecord::Migration
  def self.up
    create_table :servicetags do |t|
      t.string :name,          :null => false
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :servicetags
  end
end

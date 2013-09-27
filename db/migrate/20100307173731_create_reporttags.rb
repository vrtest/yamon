class CreateReporttags < ActiveRecord::Migration
  def self.up
    create_table :reporttags do |t|
      t.string :name,          :null => false
      t.string :description
      t.string :css_classes

      t.timestamps
    end
  end

  def self.down
    drop_table :reporttags
  end
end

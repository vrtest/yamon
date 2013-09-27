class AddCssClassesToServicetags < ActiveRecord::Migration
  def self.up
    add_column :servicetags, :css_classes, :string
  end

  def self.down
    remove_column :servicetags, :css_classes
  end
end

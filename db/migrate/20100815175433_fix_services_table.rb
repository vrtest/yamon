class FixServicesTable < ActiveRecord::Migration
  def self.up
    add_column :services, :host_id, :integer
    #could write a data migration here but don't care 
    remove_column :services, :hostname
    rename_column :services, :description, :name
  end

  def self.down
  end
end

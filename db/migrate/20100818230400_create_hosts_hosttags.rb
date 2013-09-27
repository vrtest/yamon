class CreateHostsHosttags < ActiveRecord::Migration
  def self.up
    create_table :hosts_hosttags, :id=> false do |t|
      t.integer :hosttag_id, :null => false
      t.integer :host_id, :null => false
    end
  end

  def self.down
    drop_table :hosts_hosttags
  end
end

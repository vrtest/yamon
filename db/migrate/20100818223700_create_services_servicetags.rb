class CreateServicesServicetags < ActiveRecord::Migration
  def self.up
    create_table :services_servicetags, :id=> false do |t|
      t.integer :servicetag_id, :null => false
      t.integer :service_id, :null => false
    end
  end

  def self.down
    drop_table :services_servicetags
  end
end

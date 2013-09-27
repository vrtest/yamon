class CreateReportsReporttags < ActiveRecord::Migration
  def self.up
    create_table :reports_reporttags, :id=> false do |t|
      t.integer :reporttag_id, :null => false
      t.integer :report_id, :null => false
    end
  end

  def self.down
    drop_table :reports_reporttags
  end
end

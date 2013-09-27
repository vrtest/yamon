class ReportsReporttag < ActiveRecord::Base
  validates_presence_of :report_id,:reporttag_id
end

class Alert < ActiveRecord::Base
  validates_presence_of :service_id, :date_start, :date_end, :check_status, :duration, :host_id, :service_id
  belongs_to :host
  belongs_to :service
  belongs_to :report

  ALERT_STATUS_BY_ID = [ 0 => 'OK', 1 => 'WARN', 2 => 'ERROR', 3 => 'UNKNOW' ]
  ALERT_STATUS_BY_KEY = { 'OK' => 0, 'WARN' => 1, 'ERROR' => 2, 'UNKNOW' => 3}

end

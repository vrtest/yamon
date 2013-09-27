class CurrentAlerts < ActiveRecord::Base
  validates_presence_of :hostname, :description, :check_status, :check_date, :service_output

  def check_date_human
    t = Time.at(self.check_date)
    t.strftime "%Y-%m-%d %H:%M"
  end

end

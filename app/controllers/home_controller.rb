class HomeController < ApplicationController

  INDEX_ALERT_LIMIT = 15
  INDEX_ALERT_MIN_DURATION = 300

  def index
    @alerts = Alert.where("report_id is null AND duration > "+INDEX_ALERT_MIN_DURATION.to_s)
        .order("date_start DESC")
		.limit(INDEX_ALERT_LIMIT)
    @alertsMinDuration = INDEX_ALERT_MIN_DURATION
  end
end

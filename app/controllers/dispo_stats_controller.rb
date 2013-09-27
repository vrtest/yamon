class DispoStatsController < ApplicationController
  def index
    
    #set dateMin
    params[:dateFrom] = Time.now.year.to_s+'-'+Time.now.month.to_s+'-01' if params[:dateFrom].nil?
    @dateMin = DateTime.strptime(params[:dateFrom], "%Y-%m-%d").to_time

    #set dateMax
    params[:dateTo] = (@dateMin.to_date >> 1).to_time.year.to_s+'-'+
			(@dateMin.to_date >> 1).to_time.month.to_s+'-01' if params[:dateTo].nil?
    @dateMax = DateTime.strptime(params[:dateTo], "%Y-%m-%d").to_time

    @timeRange = @dateMax - @dateMin #sec_diff dans php

    @linkToPreviousMonth = url_for(:controller => "dispo_stats", :action => "index",
	:dateFrom => (@dateMin.to_date << 1).to_time.year.to_s+'-'+
			(@dateMin.to_date << 1).to_time.month.to_s+'-01',
	:dateTo => @dateMin.year.to_s+'-'+@dateMin.to_time.month.to_s+'-01'
	)

    @linkToNextMonth = url_for(:controller => "dispo_stats", :action => "index",
        :dateFrom => (@dateMin.to_date >> 1).to_time.year.to_s+'-'+
                        (@dateMin.to_date >> 1).to_time.month.to_s+'-01',
        :dateTo => (@dateMin.to_date >> 2).to_time.year.to_s+'-'+
                        (@dateMin.to_date >> 2).to_time.month.to_s+'-01'
        )

    #get service list
    @services = ServiceStat.joins([:servicetags,:host])
                    .where("servicetags.name = 'stats'")
			        .order("hosts.name, services.name")

    #get statistics for each of them
    @services.each do |s|

      logger.debug s.inspect

      for alertStatus in 1..3
        #all alerts duration
        s.sum_status[alertStatus] = Alert.where(["check_status = ? AND service_id = ? AND date_start > ? AND date_end <= ?",
                alertStatus,s.id, @dateMin.to_s(:db), @dateMax.to_s(:db)])
                .sum('duration')
        s.percent_status[alertStatus] = s.sum_status[alertStatus] * 100 / @timeRange

	logger.debug "s.percent_status[#{alertStatus}] = #{s.sum_status[alertStatus]} * 100 / #{@timeRange}"

        #alerts duration without excluded tagged alerts
        #how do this ??
        #s.sum_status2_excluded = Alert.sum('duration',
#			:joins => [:report, :reporttags],
#			:conditions => { :reporttags => { :exclude_from_stats => 0 }}
#			)

        #this is not rails way but working ...
        # return attributes
        # see http://api.rubyonrails.org/classes/ActiveRecord/Base.html#method-c-find_by_sql
        # - sql love \_o<
        s.sum_status_excluded[alertStatus] = Alert.find_by_sql(["
          SELECT sum(alerts.duration) as sum_status
          FROM alerts
          LEFT JOIN reports ON ( alerts.report_id = reports.id)
          LEFT JOIN reports_reporttags ON ( reports.id = reports_reporttags.report_id )
          LEFT JOIN reporttags ON ( reports_reporttags.reporttag_id = reporttags.id )
          WHERE (reporttags.exclude_from_stats = 0 OR reporttags.exclude_from_stats is null)
          AND check_status = ?
          AND service_id = ?
          AND date_start > ?
          AND date_end <= ?
          ;",alertStatus,s.id, @dateMin.to_s(:db), @dateMax.to_s(:db)])[0].sum_status.to_i

          s.percent_status_excluded[alertStatus] = s.sum_status_excluded[alertStatus] * 100 / @timeRange
      end

      #time service is OK
      s.sum_status[Alert::ALERT_STATUS_BY_KEY['OK']] = 
		@timeRange - s.sum_status[Alert::ALERT_STATUS_BY_KEY['ERROR']]

      #time service is ok without excluded alerts 
      s.sum_status_excluded[Alert::ALERT_STATUS_BY_KEY['OK']] =
		@timeRange - s.sum_status_excluded[Alert::ALERT_STATUS_BY_KEY['ERROR']]

      #final service is OK - percent
      s.percent_status_excluded[Alert::ALERT_STATUS_BY_KEY['OK']] = (
		( s.sum_status_excluded[Alert::ALERT_STATUS_BY_KEY['OK']] \
		- s.sum_status[Alert::ALERT_STATUS_BY_KEY['WARN']] \
		- s.sum_status[Alert::ALERT_STATUS_BY_KEY['UNKNOW']] \
		) * 100 ) / @timeRange

      #final service disponibility
      s.disponibility = ( s.sum_status_excluded[Alert::ALERT_STATUS_BY_KEY['OK']] * 100 ) / @timeRange

    end
  end
end

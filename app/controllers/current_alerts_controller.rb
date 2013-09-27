class CurrentAlertsController < ApplicationController
  def index
	@currentAlerts = {}
	@currentAlerts['Err'] = CurrentAlerts.where('check_status = 2').order('check_date DESC')
	@currentAlerts['Warn'] = CurrentAlerts.where('check_status = 1').order('check_date DESC')
  end

  # DELETE /current_alerts/1
  # DELETE /current_alerts/1.xml
  def destroy
    @current_alert = CurrentAlerts.find(params[:id])
    @current_alert.destroy

    respond_to do |format|
      format.html { redirect_to(current_alerts_url) }
      format.js   { render :nothing => true }
    end
  end

  def delete_3h
    currentAlerts = CurrentAlerts.where('check_date < ?', 3.hours.ago.to_i)

    currentAlerts.each do |ca|
	ca.destroy
    end

    respond_to do |format|
        format.html { redirect_to(current_alerts_url) }
    end

  end

end

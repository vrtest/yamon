module AlertsHelper

  # return a css class for an alert duration
  # duration: seconds
  def getDurationCssClass(duration)
    warning_time = 360
    critical_time = 900
    death_time = 1800
    if duration < warning_time
      ret = ""
    elsif duration >= warning_time and duration < critical_time
      ret = "durationWarning"
    elsif duration >= critical_time and duration < death_time
      ret = "durationCritical"
    else
      ret = "durationDeath"
    end

    ret
  end

end

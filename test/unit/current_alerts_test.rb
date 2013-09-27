require 'test_helper'

class CurrentAlertsTest < ActiveSupport::TestCase

  def test_invalid_current_alert
    alert = CurrentAlerts.new
    assert !alert.valid?
    assert alert.errors[:hostname].any?
    assert alert.errors[:description].any?
    assert alert.errors[:check_date].any?
    assert alert.errors[:check_status].any?
    assert alert.errors[:service_output].any?
    assert !alert.save
  end

  def test_create_current_alert
    tnow = Time.now

    alert = CurrentAlerts.new
    alert.hostname = "host01"
    alert.description = "desc01"
    alert.check_date =  tnow.to_i
    alert.check_status = 2
    alert.service_output = 'timeout ...'
    alert.service_perfdata = ''

    assert alert.valid?
    assert alert.save

  end

end

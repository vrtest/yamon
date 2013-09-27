require 'test_helper'

class AlertTest < ActiveSupport::TestCase

  test "test invalid alert" do
    alert=Alert.new
    assert !alert.valid?
    assert alert.errors[:service_id].any?
    assert alert.errors[:date_start].any?
    assert alert.errors[:date_end].any?
    assert alert.errors[:check_status].any?
    assert alert.errors[:duration].any?
    assert alert.errors[:host_id].any?
    assert !alert.save
  end

  test "test create alert" do
    tnow=Time.now

    alert = Alert.new
    alert.service_id = 1
    alert.date_start = tnow-100
    alert.date_end = tnow
    alert.check_status = 2
    alert.service_output = 'timeout ...'
    alert.service_perfdata = ''
    alert.duration = 100
    alert.host_id = 1

    assert alert.valid?
    assert alert.save

  end

end

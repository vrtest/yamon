require 'test_helper'

class ServiceTest < ActiveSupport::TestCase

  def test_invalid_service
    s = Service.new()
    assert !s.valid?
    assert s.errors[:host_id].any?
    assert s.errors[:name].any?
    assert !s.save
  end

  def test_create_service
    s = Service.new()
    s.host_id = 1
    s.name = "pouet"
    assert s.save
  end

end

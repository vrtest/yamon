require 'test_helper'

class HostTest < ActiveSupport::TestCase

  def test_invalid_host
    host=Host.new
    assert !host.valid?
    assert host.errors[:name].any?
    assert !host.save
  end

  def test_create_host
    host = Host.new
    host.name= "host01"
    assert host.valid?
    assert host.save
  end

end

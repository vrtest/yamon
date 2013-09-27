require 'test_helper'

class ServicetagTest < ActiveSupport::TestCase

  def test_invalid_servicetag
    s = Servicetag.new
    assert !s.valid?
    assert s.errors[:name].any?
    assert !s.save
  end

  def test_create_servicetag
    assert Servicetag.create(
      :name => 'Planned operation',
      :description => 'Delivery, ...'
    )
  end

end

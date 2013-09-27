require 'test_helper'

class HosttagTest < ActiveSupport::TestCase

  def test_invalid_hosttag
    h=Hosttag.new
    assert !h.valid?
    assert h.errors[:name].any?
    assert !h.save
  end

  def test_create_hosttag
    h = Hosttag.new
    h.name= "host01"
    assert h.valid?

    h.description = "desc"
    h.css_classes = "css"
    assert h.valid?

    assert h.save
  end
end

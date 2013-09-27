require 'test_helper'

class ReporttagTest < ActiveSupport::TestCase

  def test_invalid_reporttag
    r = Reporttag.new
    assert !r.valid?
    assert r.errors[:name].any?
    assert !r.save
  end

  def test_create_reporttag
    r = Reporttag.new
    r.name= "host01"
    assert r.valid?

    r.description = "desc"
    r.css_classes = "css"
    assert r.valid?

    assert r.save
  end

end

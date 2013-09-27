require 'test_helper'

class ReportTest < ActiveSupport::TestCase

  def test_invalid_report
    r=Report.new
    assert !r.valid?
    assert r.errors[:label].any?
    assert !r.save
  end

  def test_create_report
    assert Report.create(
      :label => 'Internet Failure',
      :description => 'Internet is broken !'
    )
  end

end

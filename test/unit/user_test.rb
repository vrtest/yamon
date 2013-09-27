require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def test_invalid_user
    u = User.new
    assert !u.valid?
    assert u.errors[:name].any?
    assert u.errors[:hashed_password].any?
    assert u.errors[:salt].any?
    assert !u.save
  end

  def test_create_user

    u = User.new

    u.name = "John"
    assert !u.valid?

    u.password = "pouet"
    assert u.valid?
    assert u.save

  end

end

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Test relationships
  should have_one(:customer)

  # Test built-in validations
  should validate_presence_of(:username)

  should allow_value("admin").for(:role)
  should allow_value("shipper").for(:role)
  should allow_value("customer").for(:role)
  should_not allow_value("bad").for(:role)
  should_not allow_value("baker").for(:role)
  should_not allow_value("hacker").for(:role)
  should_not allow_value(10).for(:role)
  should_not allow_value("leader").for(:role)
  should_not allow_value(nil).for(:role)
 
end


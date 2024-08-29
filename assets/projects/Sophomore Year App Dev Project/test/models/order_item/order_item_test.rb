require 'test_helper'

class OrderItemTest < ActiveSupport::TestCase
  # test relationships
  should belong_to(:order)
  should belong_to(:item)

  # test simple validations with matchers
  should validate_numericality_of(:quantity).only_integer.is_greater_than(0)
  should allow_value(Date.current).for(:shipped_on)
  should allow_value(nil).for(:shipped_on)
  should allow_value(1.day.ago.to_date).for(:shipped_on)
  should allow_value(1.day.from_now.to_date).for(:shipped_on)
  should_not allow_value("bad").for(:shipped_on)
  should_not allow_value(2).for(:shipped_on)
  should_not allow_value(3.14159).for(:shipped_on)

end
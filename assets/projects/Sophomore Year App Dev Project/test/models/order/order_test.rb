require 'test_helper'

class OrderTest < ActiveSupport::TestCase

  # test relationships
  should belong_to(:customer)
  should belong_to(:address)
  should have_many(:order_items)
  should have_many(:items).through(:order_items)

  # test simple validations with matchers
  should validate_numericality_of(:products_total).is_greater_than_or_equal_to(0)
  should validate_numericality_of(:shipping).is_greater_than_or_equal_to(0)

  should allow_value(Date.today).for(:date)
  should allow_value(1.day.ago.to_date).for(:date)
  should allow_value(1.day.from_now.to_date).for(:date)
  should_not allow_value("bad").for(:date)
  should_not allow_value(2).for(:date)
  should_not allow_value(3.14159).for(:date)

end


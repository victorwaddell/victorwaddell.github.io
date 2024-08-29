require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  # Test relationships
  should belong_to(:category)
  should have_many(:order_items)
  should have_many(:item_prices)
  should have_many(:orders).through(:order_items)
  
  # Test built-in validations
  should validate_presence_of(:name)
  should validate_uniqueness_of(:name).case_insensitive
  should validate_numericality_of(:weight).is_greater_than(0)
  should validate_numericality_of(:inventory_level).is_greater_than_or_equal_to(0).only_integer
  should validate_numericality_of(:reorder_level).is_greater_than_or_equal_to(0).only_integer
end

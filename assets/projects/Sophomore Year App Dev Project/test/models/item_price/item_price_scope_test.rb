require 'test_helper'

class ItemPriceScopeTest < ActiveSupport::TestCase
  context "Within context" do
    setup do 
      create_categories
      create_pans
      create_more_pan_prices
    end

    should "have a working scope called current" do
      assert_equal [2.50, 3.60, 3.95, 6.40], ItemPrice.current.all.map(&:price).sort
    end

    should "have a working scope called chronological" do
      assert_equal [3.60, 2.50, 6.40, 3.95, 2.95, 5.75, 3.25, 3.25, 2.75, 2.75, 5.55, 2.70, 2.95, 2.25, 5.05], ItemPrice.chronological.all.map(&:price)
    end

    should "have a working scope called for_date" do
      assert_equal [3.25, 2.95, 5.75, 3.25], ItemPrice.for_date(4.months.ago.to_date).all.map(&:price)
      assert_equal [2.75, 2.75, 5.55, 2.70], ItemPrice.for_date(7.months.ago.to_date).all.map(&:price)
    end

    should "have a working scope called for_item" do
      assert_equal [3.95, 3.25, 2.95, 2.75], ItemPrice.for_item(@baking_sheet.id).all.map(&:price).sort.reverse
    end
  end
end


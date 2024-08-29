require 'test_helper'

class ItemPriceCallbackTest < ActiveSupport::TestCase
  context "Within context" do
    setup do 
      create_categories
      create_pans
      create_pan_prices_retail
    end

    should "verify that the old price end_date set to today" do
      assert_nil @bs5.end_date
      @change_price = FactoryBot.create(:item_price, item: @baking_sheet, price: 6.95, start_date: nil)
      @bs5.reload
      assert_equal Date.current, @bs5.end_date
    end

    should "verify that the new price start_date set to tomorrow" do
      @change_price = FactoryBot.create(:item_price, item: @baking_sheet, price: 4.95)
      assert_equal Date.tomorrow, @change_price.start_date
    end

    should "correctly assess that an item_price is not destroyable" do
      deny @bs1.destroy
    end
  end
end


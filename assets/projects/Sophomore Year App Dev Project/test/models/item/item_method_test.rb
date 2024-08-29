require 'test_helper'

class ItemMethodTest < ActiveSupport::TestCase
  context "Within context" do
    setup do 
      create_categories
      create_pans
    end

    should "have make_active and make_inactive methods" do
      assert @muffin_tray.active
      @muffin_tray.make_inactive
      @muffin_tray.reload
      deny @muffin_tray.active
      @muffin_tray.make_active
      @muffin_tray.reload
      assert @muffin_tray.active
    end

    should "have method for current retail prices" do
      create_pan_prices_retail
      assert_equal 5.95, @baking_sheet.current_retail_price
      tri_pan = FactoryBot.create(:item, category: @pans, name: "Triangle Pan")
      assert_nil tri_pan.current_retail_price
    end
    
    should "have method for retail prices on a given date" do
      create_pan_prices_retail
      assert_equal 4.49, @baking_sheet.retail_price_on_date(12.months.ago)
      assert_nil @baking_sheet.retail_price_on_date(36.months.ago)
      tri_pan = FactoryBot.create(:item, category: @pans, name: "Triangle Pan")
      assert_nil tri_pan.retail_price_on_date(12.months.ago)
    end

    # Test custom validation and associated method
    should "verify that the category is active in the system" do
      # inactive category
      @bad_item = FactoryBot.build(:item, category: @decorations, name: "Broken Decoration")
      deny @bad_item.valid?
      # non-existent address
      ghost = FactoryBot.build(:category, name: "Ghost")
      non_category_item = FactoryBot.build(:item, category: ghost, name: "Ghost Item")
      deny non_category_item.valid?
    end
  end
end

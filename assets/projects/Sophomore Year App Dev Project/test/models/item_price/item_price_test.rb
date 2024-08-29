require 'test_helper'

class ItemPriceTest < ActiveSupport::TestCase
  # test relationships with matchers
  should belong_to(:item)

  # test validations with matchers
  should validate_numericality_of(:price).is_greater_than_or_equal_to(0)

  context "Within context" do
    setup do 
      create_categories
      create_pans
      create_more_pan_prices
    end

    # Including the custom validation test here...
    should "verify that the item is active in the system" do
      @bad_price = FactoryBot.build(:item_price, item: @mini_muffin_tray, price: 3.45)
      deny @bad_price.valid?
    end 
  end
end


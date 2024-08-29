require 'test_helper'

class ItemPriceTest < ActiveSupport::TestCase
  # Relationships
  should belong_to :item

  # Validations
  should validate_numericality_of(:price).is_greater_than_or_equal_to(0)

  # Create Contexts
  context "Within context" do
    setup do
      create_customer_users
      create_customers
      create_addresses
      create_categories
      create_items
      create_item_prices_retail
      create_orders
      create_order_items
    end 

    # Scopes
    # test current scope
    should "shows only the current price of all items" do
      assert_equal [3.95, 4.25, 5.5, 5.75, 5.95, 8.5, 8.95], ItemPrice.current.map{|i| i.price}.sort
    end

    # test chronological scope
    should "shows that the item prices ordered by start_date DESC" do
      assert_equal [8.95, 5.75, 4.25, 5.5, 8.5, 5.95, 4.95, 7.95, 5.25, 5.5, 3.5, 8.5, 
                    3.95, 4.95, 2.95, 7.95, 4.75, 7.75, 4.49, 4.95, 4.95, 4.25, 7.25], ItemPrice.chronological.map{|i| i.price}
    end

    # test for_item scope
    should "shows all item prices for an item" do
      assert_equal [2.95, 3.5, 4.25], ItemPrice.for_item(@whisk).map{|i| i.price}.sort
      assert_equal [3.95], ItemPrice.for_item(@flour).map{|i| i.price}.sort
    end
    
    # test for_date scope
    should "shows all item active prices between a given start_date and end_date" do
      assert_equal [4.25, 4.95, 7.25], ItemPrice.for_date(24.months.ago.to_date).map{|i| i.price}.sort 
      assert_equal [3.5, 3.95, 5.25, 5.5, 8.5], ItemPrice.for_date(6.months.ago.to_date).map{|i| i.price}.sort
      assert_equal [3.95, 4.25, 5.5, 5.75, 5.95, 8.5, 8.5], ItemPrice.for_date(2.weeks.ago.to_date).map{|i| i.price}.sort
    end

    # Methods and Validations


    should "show new price dates for a newly created item" do
      @newItemPrice = FactoryBot.create(:item_price, item: @muffin_tray, price: 5.00)
      # Muffin Tray 4 Was the pre-existing price for Muffin Trays, mt4 should now have an end_date equal to today
      @mt4.reload  
      # Make sure end_date was updated to today
      assert_equal Date.today, @mt4.end_date
      # Make sure new price date is set to one day from date
      assert_equal Date.tomorrow, @newItemPrice.start_date
      @newItemPrice.destroy
    end

  end
end

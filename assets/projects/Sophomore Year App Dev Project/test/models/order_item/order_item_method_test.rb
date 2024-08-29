require 'test_helper'

class OrderItemMethodTest < ActiveSupport::TestCase
   context "Within context" do
    setup do 
      create_categories
      create_items
      create_item_prices_retail
      create_customer_users
      create_customers
      create_addresses
      create_orders
      create_order_items
    end

    should "verify that the item is active in the system" do
      @bad_order_item = FactoryBot.build(:order_item, order: @ryan_o1, item: @apple_cherry)
      deny @bad_order_item.valid?
    end 

    should "have a method which calculates the subtotal for current date" do
      assert_equal 3.95, @melanie_o1_1.subtotal
      assert_equal (3.95*4), @alexe_o3_1.subtotal
    end

    should "have a method which calculates the subtotal for a past date" do
      assert_equal 7.75, @alexe_o2_1.subtotal(1.year.ago.to_date)
      assert_equal 8.50, @alexe_o2_1.subtotal()
      assert_nil @alexe_o2_1.subtotal(3.year.ago.to_date)
    end

    should "return nil for a subtotal for a future date" do
      assert_nil @melanie_o1_1.subtotal(1.year.from_now.to_date)
    end
  end
end
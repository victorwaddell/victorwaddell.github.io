require 'test_helper'

class OrderItemScopeTest < ActiveSupport::TestCase
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

    should "have a working scope called shipped" do
      assert_equal 4, OrderItem.shipped.count
    end

    should "have a working scope called unshipped" do
      assert_equal 6, OrderItem.unshipped.count    
    end   

    should "have a scope alphabetical by item name" do
      assert_equal ["GPBO Baking Sheet","GPBO Baking Sheet","GPBO Baking Sheet","GPBO Muffin Tray","GPBO Round Cake Pan Set","GPBO Round Cake Pan Set","GPBO Square Cake Pan"	,"GPBO Whisk"	,"King Arthur All-Purpose Flour","King Arthur All-Purpose Flour"], OrderItem.alphabetical.map{|oi| oi.item.name}
    end
  end
end
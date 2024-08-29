require 'test_helper'

class ItemMethodTest < ActiveSupport::TestCase
  context "Within context" do
    setup do 
      create_categories
      create_pans
    end

    should "not destroy items that have been part of orders" do
      create_customer_users
      create_customers
      create_addresses
      create_utensils
      create_ingredients
      create_orders
      create_order_items
      deny @baking_sheet.order_items.empty?
      deny @baking_sheet.destroy
    end

    should "be able to destroy items that have not been part of orders" do
      create_customer_users
      create_customers
      create_addresses
      create_utensils
      create_ingredients
      create_orders
      create_order_items
      assert @mini_muffin_tray.order_items.empty?
      @mini_muffin_tray.destroy
      assert @mini_muffin_tray.destroyed?
    end
  end
end

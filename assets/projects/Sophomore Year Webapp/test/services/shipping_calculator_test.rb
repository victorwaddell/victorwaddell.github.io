require 'test_helper'

class ShippingCalculatorTest < ActiveSupport::TestCase 

  context "Within context" do
    setup do 
      #create appropriate contexts here
      create_customer_users
      create_customers
      create_addresses
      create_categories
      create_items
      create_item_prices_retail
      create_orders
      create_order_items
    end

    # Should calculate cost of shipping based on weight
    should 'test that shipping_calculator works correctly' do
    # Use an order less than five pounds to test that base cost is 5 dollars
    @shipping_calculator_for_o1 = ShippingCalculator.new(@alexe_o1).calculate_costs # Order is 1.3 Lbs, Cost should be base cost of 5$
    assert_equal 5, @shipping_calculator_for_o1

    # Use an order over five pounds to test increments over 5 dollars
    @shipping_calculator_for_o3 = ShippingCalculator.new(@alexe_o3).calculate_costs # Order is 20.45 Lbs, Cost is base cost plus increment = $8.75
    assert_equal 8.75, @shipping_calculator_for_o3

    # Use an order without items to test if order_items is empty
    @order_without_items = FactoryBot.build(:order)
    @shipping_calculator_for_order_without_items = ShippingCalculator.new(@order_without_items).calculate_costs
    assert_equal 0, @shipping_calculator_for_order_without_items

    # Use a ghost order to test shipping calculator
    ghost = FactoryBot.build(:customer, first_name: "Ghost")
    non_customer_order = FactoryBot.build(:order, customer: ghost, address: @alexe_a2)
    @shipping_calculator_for_non_customer_order = ShippingCalculator.new(@order_without_items).calculate_costs
    assert_equal 0, @shipping_calculator_for_non_customer_order
    end

  end
end
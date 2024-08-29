require 'test_helper'

class ShippingCalculatorTest < ActiveSupport::TestCase
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

    should "calculate the costs of shipping an order with multiple items and above the base allowed" do
      @calculator = ShippingCalculator.new(@alexe_o3)
      assert_equal 8.75, @calculator.calculate_costs
    end

    should "calculate the costs of shipping an order with one item and below the base allowed" do
      @calculator = ShippingCalculator.new(@melanie_o1)
      assert_equal 5.00, @calculator.calculate_costs
    end

    should "have zero shipping cost for an order without items yet" do
      @alexe_o4   = FactoryBot.create(:order, customer: @alexe, address: @alexe_a1, date: Date.current)
      @calculator = ShippingCalculator.new(@alexe_o4)
      assert_equal 0.00, @calculator.calculate_costs
    end

  end
end
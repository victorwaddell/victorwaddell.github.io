require 'test_helper'

class OrderScopeTest < ActiveSupport::TestCase
   context "Within context" do
    setup do 
      create_customer_users
      create_customers
      create_addresses
      create_orders
    end

    should "have a working scope called paid" do
      assert_equal [8.95, 10.25, 13.5, 24.25], Order.paid.all.map(&:grand_total).sort
    end

    should "have a working scope called chronological" do
      assert_equal [25.05, 10.25, 24.25, 16.5, 13.5, 8.95, 10.25], Order.chronological.all.map(&:grand_total)
    end

    should "have a working scope called for_customer" do
      assert_equal [10.25, 13.5, 25.05], Order.for_customer(@alexe).all.map(&:grand_total).sort
    end
  end
end


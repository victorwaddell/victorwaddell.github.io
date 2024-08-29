require 'test_helper'

class OrderMethodTest < ActiveSupport::TestCase
  require 'base64'

   context "Within context" do
    setup do 
      create_customer_users
      create_customers
      create_addresses
      create_orders
    end

    should "have a grand_total method that adds shipping and products subtotal" do
      assert_equal 5.25, @alexe_o1.products_total
      assert_equal 5.00, @alexe_o1.shipping
      assert_equal 10.25, @alexe_o1.grand_total
    end

    should "verify that the customer is active in the system" do
      # inactive customer
      @bad_order = FactoryBot.build(:order, customer: @sherry, address: @alexe_a2, payment_receipt: "dcmjgwwtsd39x6wfc1", date: 5.days.ago.to_date)
      deny @bad_order.valid?
      # non-existent customer
      ghost = FactoryBot.build(:customer, first_name: "Ghost")
      non_customer_order = FactoryBot.build(:order, customer: ghost, address: @alexe_a2)
      deny non_customer_order.valid?
    end 

    should "verify that the address is active in the system" do
      # inactive address
      @bad_order = FactoryBot.build(:order, customer: @alexe, address: @alexe_a3, payment_receipt: "dcmjgwwtsd39x6wfc1", date: 5.days.ago.to_date)
      deny @bad_order.valid?
      # non-existent address
      ghost = FactoryBot.build(:address, customer: @alexe, recipient: "Ghost")
      non_address_order = FactoryBot.build(:order, customer: @alexe, address: ghost)
      deny non_address_order.valid?
    end

    should "have a pay method which generates a receipt string" do
      assert_nil @melanie_o2.payment_receipt
      @melanie_o2.pay
      @melanie_o2.reload
      assert_not_nil @melanie_o2.payment_receipt
    end

    should "not be able to pay twice for same order" do
      assert_nil @melanie_o2.payment_receipt
      first_pay = @melanie_o2.pay
      assert_not_nil @melanie_o2.payment_receipt
      second_pay = @melanie_o2.pay
      assert_not_equal first_pay, second_pay
    end

    should "have a properly formatted payment receipt" do
      # test with a paid order to a non-billing address (i.e., zip code is not the order address zip)
      assert_equal "order: #{@alexe_o2.id}; amount_paid: #{@alexe_o2.grand_total}; received: #{@alexe_o2.date}", Base64.decode64(@alexe_o2.payment_receipt), "#{Base64.decode64(@alexe_o2.payment_receipt)}"
      # verify with payment an order to a billing address is fine too
      assert_nil @alexe_o3.payment_receipt
      @alexe_o3.pay
      assert_equal "order: #{@alexe_o3.id}; amount_paid: #{@alexe_o3.grand_total}; received: #{@alexe_o3.date}", Base64.decode64(@alexe_o3.payment_receipt), "#{Base64.decode64(@alexe_o3.payment_receipt)}"
    end

    # NEW TESTS
    should "correctly calculate total weight of the order" do
      # additional contexts
      create_categories
      create_items
      create_order_items
      # single item
      assert_equal 1.3, @alexe_o1.total_weight
      # multiple items, different quantities
      assert_equal 20.45, @alexe_o3.total_weight
      # new order with no items yet
      alexe_o4 = FactoryBot.create(:order, customer: @alexe, address: @alexe_a1)
      assert_equal 0, alexe_o4.total_weight
    end

    should "have a working class method called not_shipped" do
      create_categories
      create_items
      create_order_items
      assert_equal [25.05, 24.25, 16.5, 10.25], Order.not_shipped.map(&:grand_total).sort.reverse
    end  
    
    should "not return an array but rather an ActiveRecord::Relation for not_shipped method" do
      deny Order.not_shipped.kind_of?(Array)
      assert Order.not_shipped.kind_of?(ActiveRecord::Relation)
    end
  end
end


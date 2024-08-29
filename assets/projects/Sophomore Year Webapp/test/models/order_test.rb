require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  require 'base64'

  # test relationships
  should belong_to(:customer)
  should belong_to(:address)
  should have_many(:order_items)
  should have_many(:items).through(:order_items)

  # test simple validations with matchers
  should validate_numericality_of(:products_total).is_greater_than_or_equal_to(0)
  should validate_numericality_of(:tax).is_greater_than_or_equal_to(0)
  should validate_numericality_of(:shipping).is_greater_than_or_equal_to(0)

  should allow_value(Date.today).for(:date)
  should allow_value(1.day.ago.to_date).for(:date)
  should allow_value(1.day.from_now.to_date).for(:date)
  should_not allow_value("bad").for(:date)
  should_not allow_value(2).for(:date)
  should_not allow_value(3.14159).for(:date)
 
   context "Within context" do
    setup do 
      create_customer_users
      create_customers
      create_addresses
      create_orders
    end

    should "have a working scope called paid" do
      assert_equal [9.23, 10.62, 14.1, 25.6], Order.paid.all.map(&:grand_total).sort
    end

    should "have a working scope called chronological" do
      assert_equal [26.45, 10.62, 25.6, 17.31, 14.1, 9.23, 10.62], Order.chronological.all.map(&:grand_total)
    end

    should "have a working scope called for_customer" do
      assert_equal [10.62, 14.1, 26.45], Order.for_customer(@alexe).all.map(&:grand_total).sort
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

    should "have accessor methods for credit card data" do
      assert Order.new.respond_to? :credit_card_number
      assert Order.new.respond_to?(:credit_card_number=)
      assert Order.new.respond_to? :expiration_year
      assert Order.new.respond_to?(:expiration_year=)
      assert Order.new.respond_to? :expiration_month
      assert Order.new.respond_to?(:expiration_month=)
    end

    should "identify different types of credit card by their pattern" do
      # lengths are all correct for these tests, but prefixes are not
      assert @melanie_o2.valid?
      numbers = {4123456789012=>"VISA", 4123456789012345=>"VISA", 5123456789012345=>"MC", 5412345678901234=>"MC", 6512345678901234=>"DISC", 6011123456789012=>"DISC", 30012345678901=>"DCCB", 30312345678901=>"DCCB", 341234567890123=>"AMEX", 371234567890123=>"AMEX",7123456789012=>"N/A",30612345678901=>"N/A",351234567890123=>"N/A",5612345678901234=>"N/A",6612345678901234=>"N/A"}
      numbers.each do |num, name|
        @melanie_o2.credit_card_number = num
        assert_equal name, @melanie_o2.credit_card_type, "#{@melanie_o2.credit_card_type} :: #{@melanie_o2.credit_card_number}"
      end
    end

    should "detect different types of valid and invalid credit card numbers" do
      # similar to previous, but testing the actual validation method exists
      @melanie_o2.credit_card_number = nil
      deny @melanie_o2.valid?
      valid_numbers = %w[4123456789012 4123456789012345 5123456789012345 5412345678901234 6512345678901234 6011123456789012 30012345678901 30312345678901 341234567890123 371234567890123]
      valid_numbers.each do |num|
        @melanie_o2.credit_card_number = num
        assert @melanie_o2.valid?, "#{@melanie_o2.credit_card_number}"
      end
      invalid_numbers = %w[7123456789012 30612345678901 351234567890123 5612345678901234 6612345678901234]
      invalid_numbers.each do |num|
        @melanie_o2.credit_card_number = num
        deny @melanie_o2.valid?, "#{@melanie_o2.credit_card_number}"
      end
    end  

    should "detect different types of too-short credit card numbers" do
      # prefixes are all correct for these tests, but length is too short for card type
      assert @melanie_o2.valid?
      short_numbers = %w[412345678901 412345678901234 512345678901234 541234567890123 651234567890123 601112345678901 3001234567890 3031234567890 34123456789012 37123456789012]
      short_numbers.each do |num|
        @melanie_o2.credit_card_number = num
        deny @melanie_o2.valid?, "#{@melanie_o2.credit_card_number}"
      end
    end 

    should "detect different types of too-long credit card numbers" do
      # prefixes are all correct for these tests, but length is too long for card type
      assert @melanie_o2.valid?
      long_numbers = %w[41234567890121 41234567890123451 51234567890123451 54123456789012341 65123456789012341 60111234567890121 300123456789011 303123456789011 3412345678901231 3712345678901231]
      long_numbers.each do |num|
        @melanie_o2.credit_card_number = num
        deny @melanie_o2.valid?, "#{@melanie_o2.credit_card_number}"
      end
    end

    should "detect valid and invalid expiration dates" do
      assert @melanie_o2.valid?
      @melanie_o2.expiration_year = 1.year.ago.year
      deny @melanie_o2.valid?
      @melanie_o2.expiration_year = Date.current.year
      @melanie_o2.expiration_month = Date.current.month
      assert @melanie_o2.valid?
      @melanie_o2.expiration_year = Date.current.year
      @melanie_o2.expiration_month = Date.current.month - 1
      deny @melanie_o2.valid?
      @melanie_o2.expiration_year = Date.current.year
      @melanie_o2.expiration_month = Date.current.month + 1
      assert @melanie_o2.valid?
    end

    # NEW TESTS
    should "calculate the weight of an order" do
      create_categories
      create_items
      create_order_items
      assert_equal 1.7, @alexe_o2.total_weight
      assert_equal 4.0, @anthony_o1.total_weight
      assert_equal 5.0, @melanie_o1.total_weight
    end

    should "show orders that have unshipped items" do
      create_categories
      create_items
      create_order_items
      assert_equal [@alexe_o3, @melanie_o2, @anthony_o1, @ryan_o1], Order.not_shipped.sort
    end


  end
end


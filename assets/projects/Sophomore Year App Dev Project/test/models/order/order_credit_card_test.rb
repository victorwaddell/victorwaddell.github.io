require 'test_helper'

class OrderCreditCardTest < ActiveSupport::TestCase
   context "Within context" do
    setup do 
      create_customer_users
      create_customers
      create_addresses
      create_orders
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

  end
end


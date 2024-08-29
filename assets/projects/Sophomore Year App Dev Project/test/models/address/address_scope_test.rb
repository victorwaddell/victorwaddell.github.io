require 'test_helper'

class AddressScopeTest < ActiveSupport::TestCase
  context "Within context" do
    setup do 
      create_customer_users
      create_customers
      create_addresses
    end
    
    should "show that by_recipient places addresses in alphabetical order" do
      assert_equal ["Alex Egan", "Anthony Corletti", "Jeff Egan", "Melanie Freeman", "Ryan Flood", "Zach Egan"], Address.by_recipient.all.map(&:recipient)
    end

    should "show that by_customer places addresses in alphabetical order by customer" do
      assert_equal ["Anthony Corletti", "Alex Egan", "Jeff Egan", "Zach Egan", "Ryan Flood", "Melanie Freeman"], Address.by_customer.by_recipient.all.map(&:recipient)
    end

    should "show that there are two active addresses and one inactive address" do
      assert_equal 5, Address.active.all.count
      assert_equal ["Zach Egan"], Address.inactive.all.map(&:recipient).sort
    end

    should "show that scopes for billing and shipping" do
      assert_equal ["Alex Egan", "Anthony Corletti", "Melanie Freeman", "Ryan Flood"], Address.billing.all.map(&:recipient).sort
      assert_equal ["Jeff Egan", "Zach Egan"], Address.shipping.all.map(&:recipient).sort
    end

  end
end

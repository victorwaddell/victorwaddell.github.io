require 'test_helper'

class CustomerMethodTest < ActiveSupport::TestCase
  context "Within context" do
    setup do 
      create_customer_users
      create_customers
    end

    should "have working name methods" do
      assert_equal "Chen, Sherry", @sherry.name
      assert_equal "Melanie Freeman", @melanie.proper_name
    end

    should "have a billing_address method" do
      create_addresses
      # find the current billing address
      assert_equal @alexe_a1, @alexe.billing_address
      refute_equal @alexe_a2, @alexe.billing_address
      # verify the correct billing address after a change
      @alexe_a2.is_billing = true
      @alexe_a2.save
      refute_equal @alexe_a1, @alexe.billing_address
      assert_equal @alexe_a2, @alexe.billing_address
    end

    should "have make_active and make_inactive methods" do
      assert @melanie.active
      @melanie.make_inactive
      @melanie.reload
      deny @melanie.active
      @melanie.make_active
      @melanie.reload
      assert @melanie.active
    end
  end
end
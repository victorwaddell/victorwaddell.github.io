require 'test_helper'

class CustomerCallbackTest < ActiveSupport::TestCase

  context "Within context" do
    setup do 
      create_customer_users
      create_customers
    end

    should "strip non-digits from the phone number" do
      assert_equal "4122682323", @anthony.phone
    end

    should "correctly assess that a customer is not destroyable" do
      deny @melanie.destroy
    end
    
    should "deactivate the user if the customer is made inactive" do
      @ryan.active = false
      @ryan.save!
      @ryan.reload
      @u_ryan.reload
      deny @u_ryan.active
    end 
  end
end
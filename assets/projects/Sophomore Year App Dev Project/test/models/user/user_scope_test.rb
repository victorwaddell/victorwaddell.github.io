require 'test_helper'

class UserScopeTest < ActiveSupport::TestCase
  context "Within context" do
    setup do
      create_employee_users
    end
    
    should "have a working scope called active" do
      assert_equal ["mark","shipper","tank"], User.active.all.map(&:username).sort
    end

    should "have a working scope called inactive" do
      assert_equal ["old_shipper"], User.inactive.all.map(&:username).sort
    end

    should "have a working scope called employees" do
      create_customer_users  # need some non-employees
      assert @u_alexe.active
      assert_equal ["mark","old_shipper","shipper","tank"], User.employees.all.map(&:username).sort
      destroy_customer_users
    end

    should "have a working scope called alphabetical" do
      assert_equal ["mark","old_shipper","shipper","tank"], User.alphabetical.all.map(&:username)
    end

    should "have a working scope called by_role" do
      assert_equal ["admin","admin","shipper","shipper"], User.by_role.all.map(&:role)
    end
  end
end


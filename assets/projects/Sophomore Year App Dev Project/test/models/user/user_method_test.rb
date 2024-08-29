require 'test_helper'

class UserMethodTest < ActiveSupport::TestCase
  context "Within context" do
    setup do
      create_employee_users
    end

    should "have make_active and make_inactive methods" do
      assert @mark.active
      @mark.make_inactive
      @mark.reload
      deny @mark.active
      @mark.make_active
      @mark.reload
      assert @mark.active
    end
  end
end


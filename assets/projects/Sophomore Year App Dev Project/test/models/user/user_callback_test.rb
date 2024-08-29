require 'test_helper'

class UserCallbackTest < ActiveSupport::TestCase

  context "Within context" do
    setup do
      create_employee_users
    end

    should "correctly assess that a user is not destroyable" do
      deny @mark.destroy
    end
  end
end


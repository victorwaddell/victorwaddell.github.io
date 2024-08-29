require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # can't call this UserAuthenticationTest because of matcher...
  should have_secure_password

  # context
  context "Within context" do
    setup do
      create_employee_users
    end

    should "require users to have unique, case-insensitive usernames" do
      assert_equal "mark", @mark.username
      # try to switch to Alex's username 'tank'
      @mark.username = "TANK"
      deny @mark.valid?, "#{@mark.username}"
    end

    should "require a password for new users" do
      bad_user = FactoryBot.build(:user, username: "wheezy", password: nil)
      deny bad_user.valid?
    end
    
    should "require passwords to be confirmed and matching" do
      bad_user_1 = FactoryBot.build(:user, username: "wheezy", password: "secret", password_confirmation: nil)
      deny bad_user_1.valid?
      bad_user_2 = FactoryBot.build(:user, username: "wheezy", password: "secret", password_confirmation: "sauce")
      deny bad_user_2.valid?
    end
    
    should "require passwords to be at least four characters" do
      bad_user = FactoryBot.build(:user, username: "wheezy", password: "no", password_confirmation: "no")
      deny bad_user.valid?
    end

    should "have a role? method to use in authorization" do
      assert @mark.role?(:admin)
      deny @mark.role?(:shipper)
      assert @shipper.role?(:shipper)
      deny @shipper.role?(:admin)
    end

    should "have class method to handle authentication services" do
      assert User.authenticate('mark', 'secret')
      deny User.authenticate('mark', 'notsecret')
    end
  end
end


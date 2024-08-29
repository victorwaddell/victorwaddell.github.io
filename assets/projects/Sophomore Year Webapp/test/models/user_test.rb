require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_secure_password

  # Relationships tests
  should have_one(:customer)

  # Validations tests
  should validate_presence_of(:username)
  should validate_uniqueness_of(:username).case_insensitive
  should validate_presence_of(:password)
  should validate_presence_of(:password_confirmation)


  should allow_value("admin").for(:role)
  should allow_value("shipper").for(:role)
  should allow_value("customer").for(:role)
  should_not allow_value("bad").for(:role)
  should_not allow_value("hacker").for(:role)
  should_not allow_value(10).for(:role)
  should_not allow_value("leader").for(:role)
  should_not allow_value(nil).for(:role)

  should allow_value("12345").for(:password)
  should allow_value("secret").for(:password)
  should allow_value("Yod3l").for(:password)
  should_not allow_value("bad").for(:password)
  should_not allow_value("ha").for(:password)
  should_not allow_value("10").for(:password)
  should_not allow_value(nil).for(:password)

  # Context for testing
  context "Within context" do
    setup do
      create_customer_users
      create_employee_users
      create_customers
    end
    
    teardown do
      destroy_customers
      destroy_employee_users
      destroy_customer_users
    end

    # Scopes tests
    # test active scope
    should "shows that there are seven active users" do
      assert_equal 7, User.active.size
      assert_equal ["alexe", "anthony", "mark", "melanie", "ryan", "shipper", "tank"], User.active.map{|u| u.username}.sort
    end

    # test inactive scope
    should "shows that there are two inactive user" do
      assert_equal 2, User.inactive.size
      assert_equal ["old_shipper", "sherry"], User.inactive.map{|u| u.username}.sort
    end

    # test alphabetical scope
    should "shows that the usernames are ordered alphabetically" do
      assert_equal ["alexe", "anthony", "mark", "melanie", "old_shipper", "ryan", "sherry", "shipper", "tank"], User.alphabetical.map{|u| u.username}
    end

    # test by_role scope
    should "shows that the users are ordered by their role" do
      assert_equal ["admin", "admin", "customer", "customer", "customer", "customer", "customer", "shipper", "shipper"], User.by_role.map{|u| u.role}
      assert_equal ["tank", "mark", "alexe", "melanie", "anthony", "ryan", "sherry", "shipper", "old_shipper"], User.by_role.map{|u| u.username}
    end

    # test employees only scope
    should "shows only the employee users" do
      assert_equal 4, User.employees.size
      assert_equal ["tank", "mark", "shipper", "old_shipper"], User.employees.map{|u| u.username}
    end

    # Methods and Validations
    should "never be destroyed" do
      deny @u_alexe.destroy
    end

    should "make user active" do
      assert_equal false, @old_shipper.active?
      @old_shipper.make_active
      assert_equal true, @old_shipper.active?
    end

    should "make user inactive" do
      assert_equal true, @u_alexe.active?
      @u_alexe.make_inactive
      assert_equal false, @u_alexe.active?
    end

    should "have role methods and recognize all three roles" do
      egruberman = FactoryBot.build(:user, username: "terminator", role: "admin")
      alex_user = FactoryBot.build(:user, username: "alex", role: "customer")
      assert egruberman.role?(:admin)
      deny egruberman.role?(:shipper)
      assert alex_user.role?(:customer)
      deny alex_user.role?(:admin)
      assert @shipper.role?(:shipper)
      deny @shipper.role?(:user)
    end

    should "require a password for new users" do
      testing_require_pwd = FactoryBot.build(:user, username: "user1", password: nil)
      deny testing_require_pwd.valid?
    end

    should "require passwords to be confirmed and matching" do
      testconfirmpwd = FactoryBot.build(:user, username: "user2", password: "yodel", password_confirmation: nil)
      deny testconfirmpwd.valid?
      testconfirmpwd = FactoryBot.build(:user, username: "user3", password: "yodel", password_confirmation: "sauce")
      deny testconfirmpwd.valid?
    end
    
    should "require passwords to be at least four characters" do
      testing_pwd_length = FactoryBot.build(:user, username: "user4", password: "no")
      deny testing_pwd_length.valid?
    end
    
  end
  

end
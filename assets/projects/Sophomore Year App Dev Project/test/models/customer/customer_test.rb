require 'test_helper'

class CustomerTest < ActiveSupport::TestCase

  # Testing relationships
  should belong_to(:user)
  should have_many(:addresses)
  should have_many(:orders)
  should have_many(:order_items).through(:orders)

  # Testing validations
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)

  should allow_value("fred@fred.com").for(:email)
  should allow_value("fred@andrew.cmu.edu").for(:email)
  should allow_value("my_fred@fred.org").for(:email)
  should allow_value("fred123@fred.gov").for(:email)
  should allow_value("my.fred@fred.net").for(:email)
  
  should_not allow_value("fred").for(:email)
  should_not allow_value("fred@fred,com").for(:email)
  should_not allow_value("fred@fred.uk").for(:email)
  should_not allow_value("my fred@fred.com").for(:email)
  should_not allow_value("fred@fred.con").for(:email)
  
  should allow_value("4122683259").for(:phone)
  should allow_value("412-268-3259").for(:phone)
  should allow_value("412.268.3259").for(:phone)
  should allow_value("(412) 268-3259").for(:phone)
  
  should_not allow_value("2683259").for(:phone)
  should_not allow_value("4122683259x224").for(:phone)
  should_not allow_value("800-EAT-FOOD").for(:phone)
  should_not allow_value("412/268/3259").for(:phone)
  should_not allow_value("412-2683-259").for(:phone)

  should "have accessor methods for user" do
    assert Customer.new.respond_to? :username
    assert Customer.new.respond_to?(:username=)
    assert Customer.new.respond_to? :password
    assert Customer.new.respond_to?(:password=)
    assert Customer.new.respond_to? :password_confirmation
    assert Customer.new.respond_to?(:password_confirmation=)
    assert Customer.new.respond_to? :role
    assert Customer.new.respond_to?(:role=)
    assert Customer.new.respond_to? :greeting
    assert Customer.new.respond_to?(:greeting=)
  end

end
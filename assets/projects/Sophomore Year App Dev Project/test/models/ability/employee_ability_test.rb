require 'test_helper'

class EmployeeAbilityTest < ActiveSupport::TestCase
  context "Within context" do
    should "verify the abilities of admin users to do everything" do
      create_admin_abilities
      assert @mark_ability.can? :manage, :all
    end

    should "verify the abilities of shipper users" do
      create_shipper_abilities
      # no global privileges
      deny @shipper_ability.can? :manage, :all

      # testing particular abilities
      assert @shipper_ability.can? :show, @baking_sheet
      assert @shipper_ability.can? :index, Item
      deny @shipper_ability.can? :create, Item
      deny @shipper_ability.can? :update, @baking_sheet
      assert @shipper_ability.can? :index, Order
      assert @shipper_ability.can? :show, @alexe_o1
      deny @shipper_ability.can? :create, Order
      deny @shipper_ability.can? :update, Order
      deny @shipper_ability.can? :manage, Address
      assert @shipper_ability.can? :show, @alexe_a2
      deny @shipper_ability.can? :manage, ItemPrice
    end
  end
end
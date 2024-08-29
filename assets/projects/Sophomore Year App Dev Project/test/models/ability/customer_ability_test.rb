require 'test_helper'

class CustomerAbilityTest < ActiveSupport::TestCase
  context "Within context" do
    setup do
      create_customer_abilities
    end

    should "verify the abilities of customers" do
      # no global privileges
      deny @melanie_ability.can? :manage, :all
      
      # testing particular abilities
      deny @melanie_ability.can? :manage, ItemPrice
      assert @melanie_ability.can? :show, @baking_sheet
      assert @melanie_ability.can? :index, Item
      deny @melanie_ability.can? :create, Item
      deny @melanie_ability.can? :update, @baking_sheet
      assert @melanie_ability.can? :show, @melanie_o1
      deny @melanie_ability.can? :show, @alexe_o1
      assert @melanie_ability.can? :show, @melanie
      deny @melanie_ability.can? :show, @alexe 
      assert @melanie_ability.can? :update, @melanie
      deny @melanie_ability.can? :update, @alexe
      assert @melanie_ability.can? :show, @u_melanie
      deny @melanie_ability.can? :show, @u_alexe 
      assert @melanie_ability.can? :update, @u_melanie
      deny @melanie_ability.can? :update, @u_alexe
      assert @melanie_ability.can? :index, Order
      assert @melanie_ability.can? :checkout, Order
      assert @melanie_ability.can? :create, Order
      assert @melanie_ability.can? :add_to_cart, Order
      assert @melanie_ability.can? :create, Address
      assert @melanie_ability.can? :show, @melanie_a1
      deny @melanie_ability.can? :show, @alexe_a1
      assert @melanie_ability.can? :update, @melanie_a1
      deny @melanie_ability.can? :update, @alexe_a1
      assert @melanie_ability.can? :index, Address
    end
  end
end
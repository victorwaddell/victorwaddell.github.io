require 'test_helper'

class OrderItemTest < ActiveSupport::TestCase
  # Relationships
  should belong_to(:item)
  should belong_to(:order)

  # Validations
  should validate_numericality_of(:quantity).only_integer.is_greater_than(0)

  should allow_value(nil).for(:shipped_on)
  should allow_value(Date.today).for(:shipped_on)
  should allow_value(20.months.ago.to_date).for(:shipped_on)
  should_not allow_value("Tuesday").for(:shipped_on)

  # Create contexts
  context "Within context" do
    setup do
        create_customer_users
        create_customers
        create_addresses
        create_categories
        create_items
        create_item_prices_retail
        create_orders
        create_order_items
    end
    # Scopes
    should 'return all shipped items' do
      assert_equal ["GPBO Baking Sheet", "GPBO Baking Sheet", "GPBO Round Cake Pan Set", "King Arthur All-Purpose Flour"], OrderItem.shipped.alphabetical.map{|o| o.item.name}.sort
    end

    should 'return all unshipped items' do
      assert_equal ["GPBO Baking Sheet", "GPBO Muffin Tray", "GPBO Round Cake Pan Set", "GPBO Square Cake Pan", "GPBO Whisk", "King Arthur All-Purpose Flour"], OrderItem.unshipped.alphabetical.map{|o| o.item.name}.sort
    end

    should 'return all item names in alphabetical order' do
      assert_equal ["GPBO Baking Sheet", "GPBO Baking Sheet", "GPBO Baking Sheet", "GPBO Muffin Tray", "GPBO Round Cake Pan Set", 
                    "GPBO Round Cake Pan Set", "GPBO Square Cake Pan", "GPBO Whisk", "King Arthur All-Purpose Flour", 
                    "King Arthur All-Purpose Flour"], OrderItem.alphabetical.map{|o| o.item.name}
    end

    # Methods and Validations
    should "verify that the item is active in the system" do
      # inactive item
      @bad_item = FactoryBot.build(:order_item, order: @alexe_o1, item: @shears, quantity: 1)
      deny @bad_item.valid?
      # non-existent customer
      ghost = FactoryBot.build(:item, name: 'Ghost')
      non_item_order_item = FactoryBot.build(:order_item, order: @alexe_o1, item: ghost, )
      deny non_item_order_item.valid?
    end 

    should "test the subtotal method to ensure it is correct" do
      # Coverage not adequate on this method
      assert_nil @ryan_o1_1.subtotal(30.months.ago.to_date)
      assert_equal 15.80, @alexe_o3_1.subtotal(2.weeks.ago.to_date)
      assert_equal 5.95, @melanie_o2_1.subtotal(2.weeks.ago.to_date)
      assert_equal 11.50, @ryan_o1_1.subtotal()
      assert_nil @alexe_o1_1.subtotal(Date.tomorrow)
    end


  end


end

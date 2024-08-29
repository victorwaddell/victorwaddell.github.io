require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  # Relationships
  should belong_to(:category)
  should have_many(:item_prices)
  should have_many(:order_items)
  should have_many(:orders).through(:order_items)

  # Validations
  should validate_numericality_of(:weight).is_greater_than(0)
  should validate_numericality_of(:inventory_level).only_integer.is_greater_than_or_equal_to(0)
  should validate_numericality_of(:reorder_level).only_integer.is_greater_than_or_equal_to(0)
  should validate_uniqueness_of(:name).case_insensitive

  # Create Contexts
  context "Within context" do
    setup do
      create_categories
      create_items
    end

    # Scopes
    # test active scope
    should "shows that there are 6 active items" do
      assert_equal 7, Item.active.size
      assert_equal ["GPBO Baking Sheet", "GPBO Muffin Tray", "GPBO Round Cake Pan Set", "GPBO Square Cake Pan", "GPBO Whisk", "Home Hero Spatula Set", "King Arthur All-Purpose Flour"], Item.active.map{|i| i.name}.sort
    end

    # test inactive scope
    should "shows that there is 2 inactive items" do
      assert_equal 2, Item.inactive.size
      assert_equal ["GPBO Mini Muffin Tray", "Kitchen Shears"], Item.inactive.map{|i| i.name}.sort
    end

    # test alphabetical scope
    should "shows that the names are ordered alphabetically" do
      assert_equal ["GPBO Baking Sheet", "GPBO Mini Muffin Tray", "GPBO Muffin Tray", "GPBO Round Cake Pan Set", "GPBO Square Cake Pan", "GPBO Whisk", "Home Hero Spatula Set", "King Arthur All-Purpose Flour", "Kitchen Shears"], Item.alphabetical.map{|i| i.name}
    end

    # test featured scope
    should "shows the featured items" do
      assert_equal ["GPBO Muffin Tray", "GPBO Round Cake Pan Set"], Item.featured.map{|i| i.name}.sort
    end

    # test to_reorder scope
    should "shows that the items that need to be reordered" do
      assert_equal 2, Item.to_reorder.size
      assert_equal ["GPBO Mini Muffin Tray", "Kitchen Shears"], Item.to_reorder.map{|i| i.name}.sort
    end

    # test for_category scope
    should "shows that the items of a specific category" do
      assert_equal ["GPBO Baking Sheet", "GPBO Mini Muffin Tray", "GPBO Muffin Tray", "GPBO Round Cake Pan Set", "GPBO Square Cake Pan"], Item.for_category(@pans).all.map{|i| i.name}.sort
    end

    # Methods and Validations
    should "verify that the category is active in the system" do
      # inactive category
      bad_item = FactoryBot.build(:item, name: 'bad_item', category: @decorations)
      deny bad_item.valid?
      # non-existent category
      ghost = FactoryBot.build(:category, name: "Ghost")
      non_category_item = FactoryBot.build(:item, name: 'bad_item2', category: ghost)
      deny non_category_item.valid?
    end 

    should "allow one and deny one destroy" do
      create_customer_users
      create_customers
      create_addresses
      create_item_prices_retail
      create_orders
      create_order_items
      deny @flour.destroy
      assert @shears.destroy
    end

    should "have make_active and make_inactive methods" do
      assert @round_cake_pans.active
      @round_cake_pans.make_inactive
      @round_cake_pans.reload
      deny @round_cake_pans.active
      @round_cake_pans.make_active
      @round_cake_pans.reload
      assert @round_cake_pans.active
    end

    should "should return the current retail price of an item" do
      create_item_prices_retail
      assert_equal 5.95, @baking_sheet.current_retail_price
      assert_equal 3.95, @flour.current_retail_price
      assert_nil @shears.current_retail_price
    end

    should "return the retail price of an item on a date" do
      create_item_prices_retail
      # Over two weeks ago, the price of whisks were 3.50
      assert_equal 3.50, @whisk.retail_price_on_date(6.months.ago.to_date)
      # Over two weeks ago, the price of spatulas were 8.50
      assert_equal 8.50, @spatula.retail_price_on_date(6.months.ago.to_date)
      # Currently, the price of whisks are 4.25
      assert_equal 4.25, @whisk.retail_price_on_date(2.days.ago.to_date)
    end

  end


end

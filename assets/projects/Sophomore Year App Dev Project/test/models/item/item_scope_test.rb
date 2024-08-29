require 'test_helper'

class ItemScopeTest < ActiveSupport::TestCase
  context "Within context" do
    setup do 
      create_categories
      create_pans
    end

    should "order results alphabetically" do
      assert_equal ["GPBO Baking Sheet","GPBO Mini Muffin Tray","GPBO Muffin Tray","GPBO Round Cake Pan Set","GPBO Square Cake Pan"], Item.alphabetical.all.map(&:name)
    end

    should "have active and inactive scopes" do
      assert_equal ["GPBO Baking Sheet","GPBO Muffin Tray","GPBO Round Cake Pan Set","GPBO Square Cake Pan"], Item.active.all.map(&:name).sort
      assert_equal ["GPBO Mini Muffin Tray"], Item.inactive.all.map(&:name).sort
    end

    should "have for_category scope" do
      create_utensils # added so there are multipe categories
      assert_equal ["GPBO Baking Sheet","GPBO Mini Muffin Tray","GPBO Muffin Tray","GPBO Round Cake Pan Set","GPBO Square Cake Pan"], Item.for_category(@pans).all.map(&:name).sort
      assert_equal ["GPBO Whisk","Home Hero Spatula Set","Kitchen Shears"], Item.for_category(@utensils).all.map(&:name).sort
    end

    should "have to_reorder scope" do
      create_utensils # @pans has reorder < inventory and @utensils has reorder = inventory
      assert_equal ["GPBO Mini Muffin Tray","Kitchen Shears"], Item.to_reorder.all.map(&:name).sort
    end

    should "have featured scope" do
      assert_equal ["GPBO Muffin Tray","GPBO Round Cake Pan Set"], Item.featured.all.map(&:name).sort
    end

    should "have a scope to find items by partial name" do
      assert_equal ["GPBO Mini Muffin Tray","GPBO Muffin Tray",], Item.search('muffin').all.map(&:name).sort
    end
  end
end

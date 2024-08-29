require 'test_helper'

class CategoryScopeTest < ActiveSupport::TestCase
  context "Within context" do
    setup do 
      create_categories
    end

    should "show that scope exists for alphabeticizing categories" do
      assert_equal %w[Decorations Ingredients Pans Utensils], Category.alphabetical.all.map(&:name)
    end

    should "show that there are three active categories and one inactive category" do
      assert_equal %w[Ingredients Pans Utensils], Category.active.all.map(&:name).sort
      assert_equal ["Decorations"], Category.inactive.all.map(&:name).sort
    end
  end
end

require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # Relationships tests
  should have_many(:items)

  # Validations tests
  should validate_uniqueness_of(:name).case_insensitive

  # Create Contexts
  context "Within context" do
    setup do
      create_categories
    end

    # Scopes tests
    # test active scope
    should "shows that there are 3 active categories" do
      assert_equal 3, Category.active.size
      assert_equal ["Ingredients", "Pans", "Utensils"], Category.active.map{|c| c.name}.sort
    end

    # test inactive scope
    should "shows that there is 1 inactive categories" do
      assert_equal 1, Category.inactive.size
      assert_equal ["Decorations"], Category.inactive.map{|c| c.name}.sort
    end

    # test alphabetical scope
    should "shows that the names are ordered alphabetically" do
      assert_equal ["Decorations", "Ingredients", "Pans", "Utensils"], Category.alphabetical.map{|c| c.name}
    end
    
    # Methods and Validations tests
    should "never be destroyed" do
      deny @pans.destroy
    end

    should "have make_active and make_inactive methods" do
      assert @pans.active
      @pans.make_inactive
      @pans.reload
      deny @pans.active
      @pans.make_active
      @pans.reload
      assert @pans.active
    end

  end


end

require 'test_helper'

class CategoryMethodTest < ActiveSupport::TestCase
  context "Within context" do
    setup do 
      create_categories
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

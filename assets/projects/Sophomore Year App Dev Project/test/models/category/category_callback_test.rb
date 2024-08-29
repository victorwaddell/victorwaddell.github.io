require 'test_helper'

class CategoryCallbackTest < ActiveSupport::TestCase
  context "Within context" do
    setup do 
      create_categories
    end

    should "correctly assess that a customer is not destroyable" do
      deny @pans.destroy
    end
  end
end

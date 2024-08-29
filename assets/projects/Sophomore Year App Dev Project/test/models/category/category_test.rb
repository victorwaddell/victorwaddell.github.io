require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # Test relationships
  should have_many(:items)
  
  # Test validations
  should validate_presence_of(:name)
  should validate_uniqueness_of(:name).case_insensitive
end

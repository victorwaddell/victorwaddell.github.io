require 'test_helper'

class SearchControllerTest < ActionDispatch::IntegrationTest

  test "should not do anything with a blank query" do
    login_customer
    get search_path()
    assert_nil assigns[:query]
    assert_response :redirect
  end

  test "should search for only items as a customer" do
    login_customer
    get search_path(query: 'baking')
    assert_not_nil assigns[:query]
    assert_not_nil assigns[:items]
    assert_not_nil assigns[:total_hits]
    assert_nil assigns[:customers]
    assert_response :success
  end

  test "should not create session without proper creds" do
    login_admin
    get search_path(query: 'baking')
    assert_not_nil assigns[:query]
    assert_not_nil assigns[:items]
    assert_not_nil assigns[:customers]
    assert_not_nil assigns[:total_hits]
    assert_response :success
  end
end
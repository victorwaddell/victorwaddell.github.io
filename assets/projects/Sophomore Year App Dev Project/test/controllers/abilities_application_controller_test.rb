require 'test_helper'

class AbilitiesApplicationControllerTest < ActionDispatch::IntegrationTest

  # A few tests to make sure abilities were properly applied at the controller
  # level and the exception is properly handled
  setup do
    create_customer_users
    create_employee_users
    create_customers
    create_addresses
    create_categories
    create_items
    create_orders
  end

  test "an admin can update items" do
    login_admin
    get edit_item_path(@baking_sheet)
    assert_response :success
  end

  test "a customer can read his own information" do
    login_customer
    get customer_path(@jblake)
    assert_response :success
  end

  test "a customer cannot see other customers" do
    login_customer
    get customer_path(@melanie)
    assert_equal "You are not authorized to perform this action.", flash[:error]
    assert_redirected_to home_path
  end

  test "a customer cannot update other customers" do
    login_customer
    get edit_customer_path(@anthony)
    assert_equal "You are not authorized to perform this action.", flash[:error]
    assert_redirected_to home_path
  end

  test "a customer cannot add new items" do
    login_customer
    get new_item_path
    assert_equal "You are not authorized to perform this action.", flash[:error]
    assert_redirected_to home_path
  end

  test "a shipper cannot read customer information" do
    login_shipper
    get customer_path(@melanie)
    assert_equal "You are not authorized to perform this action.", flash[:error]
    assert_redirected_to home_path
  end

  test "a shipper cannot update items" do
    login_shipper
    patch item_path(@baking_sheet)
    assert_equal "You are not authorized to perform this action.", flash[:error]
    assert_redirected_to home_path
  end

end
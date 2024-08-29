require "test_helper"

class AddressesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_customer
    @address = FactoryBot.create(:address, customer: @jblake, is_billing: true)
  end

  test "should get index" do
    get addresses_path
    assert_response :success
    assert_not_nil assigns(:active_addresses)
    assert_not_nil assigns(:inactive_addresses)
  end

  test "should get new" do
    get new_address_path
    assert_response :success
  end

  test "should create address" do
    assert_difference('Address.count') do
      post addresses_path, params: { address: { customer_id: @jblake.id, is_billing: true, recipient: "Fred", street_1: "Arch Street", city: "Keene", state: "NH", zip: "03431", active: true } }
    end
    assert_equal "The address was added to John Blake.", flash[:notice]
    assert_redirected_to customer_path(@jblake)

    post addresses_path, params: { address: { customer_id: nil, is_billing: true, recipient: "Fred", street_1: "Arch Street", city: "Keene", state: "NH", zip: nil, active: true } }
    assert_template :new
  end

  test "should show address" do
    get address_path(@address)
    assert_response :success
  end

  test "should get edit" do
    get edit_address_path(@address)
    assert_response :success
  end

  test "should update address" do
    patch address_path(@address), params: { address: { customer_id: @jblake.id, is_billing: true, recipient: "Fred", street_1: "Arch Street", city: "Keene", state: "NH", zip: "03431", active: true } }
    assert_redirected_to addresses_path #address_path(@address)

    patch address_path(@address), params: { address: { customer_id: nil, is_billing: true, recipient: "Fred", street_1: "Arch Street", city: "Keene", state: "NH", zip: nil, active: true } }
    assert_template :edit
  end

end
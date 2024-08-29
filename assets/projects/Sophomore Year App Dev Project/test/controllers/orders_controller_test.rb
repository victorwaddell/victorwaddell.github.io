require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customer = FactoryBot.create(:customer)
    @address = FactoryBot.create(:address, customer: @customer, is_billing: true)
    @category = FactoryBot.create(:category)
    @item = FactoryBot.create(:item, category: @category)
    @item_price = FactoryBot.create(:item_price, item: @item, price: 1.5)
    @order = FactoryBot.create(:order, customer: @customer, address: @address)
  end

  test "should get index as admin" do
    login_admin
    get orders_path
    assert_not_nil assigns(:pending_orders)
    assert_response :success
    
    assert_not_nil assigns(:past_orders)
  end

  test "should get index as customer" do
    login_customer
    get orders_path
    assert_response :success
    assert_not_nil assigns(:all_orders)
    assert_nil assigns(:past_orders)
  end

  test "should show order" do
    login_customer
    @address_jb = FactoryBot.create(:address, customer: @jblake, is_billing: true)
    @order_jb = FactoryBot.create(:order, customer: @jblake, address: @address_jb)
    get order_path(@order_jb)
    assert_response :success
    assert_not_nil assigns(:previous_orders)
    assert_not_nil assigns(:order_items)
  end

  test "should create order" do
    login_customer
    assert_difference('Order.count') do
      post orders_path, params: { order: { customer_id: @customer.id, address_id: @address.id, credit_card_number: '4444333322221111', expiration_year: '2027', expiration_month: '12' } }
    end
    assert_equal "Thank you for ordering from GPBO.", flash[:notice]
    assert_redirected_to order_path(Order.last)
  end

  test "should redirect back to checkout if bad credit card number" do
    login_customer
    post orders_path, params: { order: { customer_id: @customer.id, address_id: @address.id, credit_card_number: '44332211', expiration_year: '2027', expiration_month: '12' } }
    assert_redirected_to checkout_path()
  end

  test "should redirect back to checkout if invalid expiration date" do
    login_customer
    post orders_path, params: { order: { customer_id: @customer.id, address_id: @address.id, credit_card_number: '4444333322221111', expiration_year: '2022', expiration_month: '2' } }
    assert_redirected_to checkout_path()
  end

end
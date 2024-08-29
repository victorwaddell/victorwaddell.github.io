require 'test_helper'

class CartControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_customer
    @category = FactoryBot.create(:category)
    @item = FactoryBot.create(:item, category: @category)
    @item_price = FactoryBot.create(:item_price, item: @item, price: 1.5)
  end

  test "should show the cart" do
    get view_cart_path
    assert_response :success
    assert_not_nil assigns(:items_in_cart)
    assert_not_nil assigns(:subtotal)
    assert_not_nil assigns(:shipping_cost)
    assert_not_nil assigns(:total)
  end

  test "should add item to the cart" do
    get add_item_path(@item)
    assert_response :redirect
    assert_equal "#{@item.name} was added to cart.", flash[:notice]
  end

  test "should remove item from the cart" do
    get remove_item_path(@item)
    assert_response :redirect
    assert_equal "#{@item.name} was removed from cart.", flash[:notice]
  end

  test "should empty the cart" do
    get empty_cart_path
    assert_response :redirect
    assert_equal "Cart is emptied.", flash[:notice]
  end

  test "should go to checkout cart to prepare for order creation" do
    get checkout_path
    assert_response :success
    assert_not_nil assigns(:items_in_cart)
    assert_not_nil assigns(:subtotal)
    assert_not_nil assigns(:shipping_cost)
    assert_not_nil assigns(:total)
    assert_not_nil assigns(:addresses)
    assert_not_nil assigns(:order)
  end

end
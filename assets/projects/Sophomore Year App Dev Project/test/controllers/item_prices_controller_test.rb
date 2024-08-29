require "test_helper"

class ItemPricesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_admin
    @category = FactoryBot.create(:category)
    @item = FactoryBot.create(:item, category: @category)
  end

  test "should get new" do
    get new_item_price_path(item_id: @item.id)
    assert_response :success
    assert_not_nil assigns(:item)
  end

  test "should create new price" do
    assert_difference('ItemPrice.count') do
      post item_prices_path, params: { item_price: { item_id: @item.id, price: 14.95 } }
    end
    assert_equal "Successfully updated the price.", flash[:notice]
    assert_redirected_to item_path(ItemPrice.last.item)

    post item_prices_path, params: { item_price: { item_id: @item.id, price: nil } }
    assert_template :new, locals: { item: @item }
  end

  test "should not have generic routes (i.e., not using resources :item_prices)" do
    @item_price = FactoryBot.create(:item_price, item: @item)
    assert_raise ActionController::UrlGenerationError do get url_for(controller: "item_prices", action: "index") end
    assert_raise ActionController::UrlGenerationError do get url_for(controller: "item_prices", action: "show", id: "#{@item_price.id}") end
    assert_raise ActionController::UrlGenerationError do get url_for(controller: "item_prices", action: "edit", id: "#{@item_price.id}") end
    assert_raise ActionController::UrlGenerationError do get url_for(controller: "item_prices", action: "update", id: "#{@item_price.id}") end
    assert_raise ActionController::UrlGenerationError do get url_for(controller: "item_prices", action: "destroy", id: "#{@item_price.id}") end
  end

end
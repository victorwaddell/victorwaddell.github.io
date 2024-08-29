require "test_helper"

class ItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_admin
    @category = FactoryBot.create(:category)
    @item = FactoryBot.create(:item, category: @category, name: "Old Pan")
  end

  test "should get index for all categories" do
    get items_path
    assert_response :success
    assert_not_nil assigns(:categories)
    assert_not_nil assigns(:featured_items)
    assert_not_nil assigns(:other_items)
  end

  test "should get index for a specific category" do
    get items_path(category: @category)
    assert_response :success
    assert_not_nil assigns(:categories)
    assert_not_nil assigns(:featured_items)
    assert_not_nil assigns(:other_items)
  end

  test "should show item as admin" do
    get item_path(@item)
    assert_response :success
    assert_not_nil assigns(:prices)
    assert_not_nil assigns(:similar_items)
  end

  test "should toggle item active state" do
    patch toggle_active_path(@item)
    assert_response :redirect
    assert_equal "Old Pan was made inactive", flash[:notice]
    patch toggle_active_path(@item)
    assert_response :redirect
    assert_equal "Old Pan was made active", flash[:notice]
  end

  test "should toggle item featured state" do
    patch toggle_feature_path(@item)
    assert_response :redirect
    assert_equal "Old Pan is now featured", flash[:notice]
    patch toggle_feature_path(@item)
    assert_response :redirect
    assert_equal "Old Pan is no longer featured", flash[:notice]
  end

  test "should get new" do
    get new_item_path
    assert_response :success
  end

  test "should create item" do
    assert_difference('Item.count') do
      post items_path, params: { item: { category_id: @category.id, name: "New Pan", description: "A new pan", color: "shiny", weight: 1.0, inventory_level: 100, reorder_level: 25, is_featured: false, active: true } }
    end
    assert_equal "New Pan was added to the system.", flash[:notice]
    assert_redirected_to item_path(Item.last)

    post items_path, params: { item: { category_id: nil, name: "New Pan", description: "A new pan", color: "shiny", weight: 1.0, inventory_level: 100, reorder_level: 25, is_featured: false, active: true } }
    assert_template :new
  end

  test "should get edit" do
    get edit_item_path(@item)
    assert_response :success
  end

  test "should update item" do
    patch item_path(@item), params: { item: { category_id: @category.id, name: @item.name, description: "An older pan", color: @item.color, weight: @item.weight, inventory_level: 100, reorder_level: 25, is_featured: false, active: true } }
    assert_redirected_to item_path(@item)

    patch item_path(@item), params: { item: { category_id: nil, name: @item.name, description: "An older pan", color: @item.color, weight: @item.weight, inventory_level: nil, reorder_level: 25, is_featured: false, active: true } }
    assert_template :edit
  end

  test "should destroy item" do
    assert_difference('Item.count', -1) do
      delete item_path(@item)
    end
    assert_redirected_to items_path
  end
  
  test "should not destroy item that has been ordered" do
    create_all_quietly
    assert_difference('Item.count', 0) do
      delete item_path(@baking_sheet)
    end
    assert_redirected_to item_path(@baking_sheet)
  end

end
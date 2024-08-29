require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_admin
    @category = FactoryBot.create(:category)
  end

  test "should get index" do
    get categories_path
    assert_response :success
    assert_not_nil assigns(:active_categories)
    assert_not_nil assigns(:inactive_categories)
  end

  test "should get new" do
    get new_category_path
    assert_response :success
  end

  test "should create category" do
    assert_difference('Category.count') do
      post categories_path, params: { category: { active: true, name: "clothing"} }
    end
    assert_equal "Successfully added clothing to the system.", flash[:notice]
    assert_redirected_to categories_path
  end

  test "should not create invalid category" do
    post categories_path, params: { category: { active: true, name: nil} }
    assert_template :new
  end

  test "should get edit" do
    get edit_category_path(@category)
    assert_response :success
  end

  test "should update category" do
    patch category_path(@category), params: { category: { active: false, name: @category.name} }
    assert_redirected_to categories_path
  end

  test "should not update an invalid officer" do
    patch category_path(@category), params: { category: { active: true, name: nil} }
    assert_template :edit
  end

  test "should not have a show or destroy method" do
    assert_raise ActionController::UrlGenerationError do get url_for(controller: "categories", action: "show", id: "#{@category.id}") end
    assert_raise ActionController::UrlGenerationError do get url_for(controller: "categories", action: "destroy", id: "#{@category.id}") end
  end
end

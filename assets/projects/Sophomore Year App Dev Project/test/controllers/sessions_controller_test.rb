require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  test "should get new" do
    get login_path
    assert_response :success
  end

  test "should create session with proper creds" do
    login_customer
    assert_not_nil session[:user_id]
    assert_not_nil session[:cart]
    assert_redirected_to home_path
  end

  test "should not create session without proper creds" do
    get login_path
    post sessions_path, params: { username: "ted", password: "notsecret" }
    assert_nil session[:user_id]
    assert_nil session[:cart]
    assert_template :new
  end

  test "should destroy session" do
    login_customer
    assert_not_nil session[:user_id]
    assert_not_nil session[:cart]
    get logout_path
    assert_nil session[:user_id]
    assert_nil session[:cart]
    assert_redirected_to home_path
  end
end
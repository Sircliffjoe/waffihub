require "test_helper"

class Admin::PartnershipsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_partnerships_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_partnerships_show_url
    assert_response :success
  end

  test "should get new" do
    get admin_partnerships_new_url
    assert_response :success
  end

  test "should get edit" do
    get admin_partnerships_edit_url
    assert_response :success
  end

  test "should get create" do
    get admin_partnerships_create_url
    assert_response :success
  end

  test "should get update" do
    get admin_partnerships_update_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_partnerships_destroy_url
    assert_response :success
  end
end

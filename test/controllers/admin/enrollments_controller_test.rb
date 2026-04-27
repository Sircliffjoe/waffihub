require "test_helper"

class Admin::EnrollmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_enrollments_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_enrollments_show_url
    assert_response :success
  end
end

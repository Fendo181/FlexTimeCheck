require 'test_helper'

class TimeCheckPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get time_check_pages_home_url
    assert_response :success
  end

  test "should get help" do
    get time_check_pages_help_url
    assert_response :success
  end

end

require "test_helper"

class NoticeControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get notice_show_url
    assert_response :success
  end
end

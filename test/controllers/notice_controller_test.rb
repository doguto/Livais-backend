require "test_helper"

class NoticeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get notice_index_url
    assert_response :success
  end
end

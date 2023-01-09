require "test_helper"

class TrendsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get trends_index_url
    assert_response :success
  end
end

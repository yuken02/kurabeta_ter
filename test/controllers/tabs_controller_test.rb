require "test_helper"

class TabsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get tabs_create_url
    assert_response :success
  end
end

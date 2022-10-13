require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get under_construction" do
    get static_pages_under_construction_url
    assert_response :success
  end
end

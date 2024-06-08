require "test_helper"

class FindingsControllerTest < ActionDispatch::IntegrationTest
  test "#index is found" do
    get findings_url
    assert_response :success
  end
end

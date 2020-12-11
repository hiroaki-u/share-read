require 'test_helper'

class GuestSessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get guest_sessions_create_url
    assert_response :success
  end

end

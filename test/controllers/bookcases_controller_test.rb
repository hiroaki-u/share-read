require 'test_helper'

class BookcasesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get bookcases_create_url
    assert_response :success
  end

  test "should get destroy" do
    get bookcases_destroy_url
    assert_response :success
  end

end

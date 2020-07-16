require 'test_helper'

class CookingsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get cookings_new_url
    assert_response :success
  end

  test "should get edit" do
    get cookings_edit_url
    assert_response :success
  end

end

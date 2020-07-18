require 'test_helper'

class Admins::CookingControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get admins_cooking_edit_url
    assert_response :success
  end

end

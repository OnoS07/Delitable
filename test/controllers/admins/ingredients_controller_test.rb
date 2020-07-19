require 'test_helper'

class Admins::IngredientsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get admins_ingredients_edit_url
    assert_response :success
  end

end

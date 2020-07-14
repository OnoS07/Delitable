require 'test_helper'

class IngredientsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get ingredients_new_url
    assert_response :success
  end

  test "should get edit" do
    get ingredients_edit_url
    assert_response :success
  end

end

require 'test_helper'

class CartItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get confirm" do
    get cart_items_confirm_url
    assert_response :success
  end

end

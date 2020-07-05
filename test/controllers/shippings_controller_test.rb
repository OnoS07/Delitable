require 'test_helper'

class ShippingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get shippings_index_url
    assert_response :success
  end

  test "should get show" do
    get shippings_show_url
    assert_response :success
  end

end

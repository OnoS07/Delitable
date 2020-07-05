require 'test_helper'

class Admins::OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get admins_orders_top_url
    assert_response :success
  end

  test "should get index" do
    get admins_orders_index_url
    assert_response :success
  end

  test "should get show" do
    get admins_orders_show_url
    assert_response :success
  end

end

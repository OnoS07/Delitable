require 'test_helper'

class CustomersControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    get customers_show_url
    assert_response :success
  end

  test 'should get edit' do
    get customers_edit_url
    assert_response :success
  end

  test 'should get delete' do
    get customers_delete_url
    assert_response :success
  end
end

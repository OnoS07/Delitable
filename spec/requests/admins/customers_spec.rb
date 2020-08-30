require 'rails_helper'

RSpec.describe 'Admins::Customers', type: :request do
  before(:each) do
    @customer = create(:customer)
    @admin = create(:admin)
    sign_in @admin
  end
  it '顧客一覧画面が表示できる' do
    get admins_customers_path
    expect(response).to have_http_status(200)
  end
  it '顧客詳細画面が表示できる' do
    get admins_customer_path(@customer)
    expect(response).to have_http_status(200)
  end

  it '顧客編集画面が表示できる' do
    get edit_admins_customer_path(@customer)
    expect(response).to have_http_status(200)
  end
  it '顧客情報の更新リクエストが成功する' do
    put admins_customer_path(@customer), params: { customer: FactoryBot.attributes_for(:customer) }
    expect(response).to have_http_status(302)
  end
  it '顧客情報が更新される' do
    expect do
      put admins_customer_path(@customer), params: { customer: FactoryBot.attributes_for(:customer, account_name: 'update_name') }
    end.to change { Customer.find(@customer.id).account_name }.from(@customer.account_name).to('update_name')
  end
  it '値が正しくない場合、顧客情報が更新されない' do
    expect do
      put admins_customer_path(@customer), params: { customer: FactoryBot.attributes_for(:customer, name: nil) }
    end.to_not change { Customer.find(@customer.id).account_name }
  end
end

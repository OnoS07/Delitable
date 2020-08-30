require 'rails_helper'

RSpec.describe 'Shippings', type: :request do
  before do
    @customer = create(:customer)
    sign_in @customer
  end
  it '配送先の一覧画面が表示できる' do
    get customers_shippings_path(@customer)
    expect(response).to have_http_status(200)
  end

  it '配送先の新規作成リクエストが成功する' do
    post customers_shippings_path, params: { shipping: FactoryBot.attributes_for(:shipping) }
    expect(response).to have_http_status(302)
  end
  it '配送先が1件増える' do
    expect do
      post customers_shippings_path, params: { shipping: FactoryBot.attributes_for(:shipping) }
    end.to change(Shipping, :count).by(1)
  end
  it '値が正しくない場合、配送先が新規作成されない' do
    expect do
      post customers_shippings_path, params: { shipping: FactoryBot.attributes_for(:shipping, postcode: 12_345_678) }
    end.to_not change(Shipping, :count)
  end

  context '配送先が必要なリクエスト' do
    before do
      @shipping = create(:shipping, customer_id: @customer.id)
    end

    it '配送先の編集画面が表示できる' do
      get edit_customers_shipping_path(@shipping)
      expect(response).to have_http_status(200)
    end
    it '配送先の更新リクエストが成功する' do
      put customers_shipping_path(@shipping), params: { shipping: FactoryBot.attributes_for(:shipping) }
      expect(response).to have_http_status(302)
    end
    it '配送先が更新される' do
      expect do
        put customers_shipping_path(@shipping), params: { shipping: FactoryBot.attributes_for(:shipping, address: 'updata-address') }
      end.to change { Shipping.find(@shipping.id).address }.from(@shipping.address).to('updata-address')
    end
    it '値が正しくない場合、配送先が更新されない' do
      expect do
        put customers_shipping_path(@shipping), params: { shipping: FactoryBot.attributes_for(:shipping, address: nil) }
      end.to_not change { Shipping.find(@shipping.id).address }
    end

    it '配送先の削除リクエストが成功する' do
      delete customers_shipping_path(@shipping)
      expect(response).to redirect_to customers_shippings_path
    end
    it '配送先が1件減る' do
      expect do
        delete customers_shipping_path(@shipping)
      end.to change(Shipping, :count).by(-1)
    end
  end
end

require 'rails_helper'

RSpec.describe 'Homes', type: :request do
  it 'トップ画面が表示される' do
    get top_path
    expect(response).to have_http_status(200)
  end
  it 'アバウト画面が表示される' do
    get about_path
    expect(response).to have_http_status(200)
  end

  it 'ゲストログインができる' do
    @customer = Customer.create(email: 'gest@gest', password: 'gestgest', account_name: 'ゲストユーザー')
    post homes_guest_sign_in_path
    expect(response).to redirect_to root_path
  end
end

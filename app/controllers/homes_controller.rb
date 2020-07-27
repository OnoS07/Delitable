class HomesController < ApplicationController
  def top; end

  def about; end

  def new_guest
    customer = Customer.find_or_create_by!(email: 'guest@gest') do |gest|
      gest.password = SecureRandom.urlsafe_base64
      gest.account_name = 'ゲストユーザー'
    end
    sign_in customer
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました'
  end
end

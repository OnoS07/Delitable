class HomesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def top; end

  def about; end

  def new_guest
    customer = Customer.find_by!(email: 'gest@gest') do |gest|
      gest.password = gestgest
      gest.account_name = 'ゲストユーザー'
    end
    sign_in customer
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました'
  end
end

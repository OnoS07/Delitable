class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details
  has_many :products, through: :order_details

  enum payment_method: { 銀行振込: false, クレジットカード: true }
  enum order_status: { 入金待ち: 0, 入金確認: 1, 商品準備中: 2, 発送準備中: 3, 発送済み: 4 }

  validates :postode, presence: true, format: { with: /\A\d{7}\z/ }
  validates :address, presence: true
  validates :name, presence: true
  validates :postage, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :total_products_cost, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
end

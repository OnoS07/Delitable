class Product < ApplicationRecord
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_details

  attachment :product_image

  enum is_active: { 売り切れ: false, 販売中: true }
end

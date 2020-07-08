class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product

  enum work_status: { 着手不可: 0, 準備待ち: 1, 発送準備中: 2, 発送準備完了: 3 }
end

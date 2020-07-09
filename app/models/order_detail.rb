class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product

  enum work_status: { 着手不可: 0, 準備待ち: 1, 商品準備中: 2, 準備完了: 3 }
end

class ChangeOrderStatusToOrderDetail < ActiveRecord::Migration[5.2]
  def change
    rename_table :order_statuses, :order_details
  end
end

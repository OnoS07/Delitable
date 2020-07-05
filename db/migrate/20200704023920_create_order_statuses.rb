class CreateOrderStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :order_statuses do |t|
      t.integer :product_id
      t.integer :order_id
      t.integer :count
      t.integer :price
      t.integer :work_status

      t.timestamps
    end
  end
end

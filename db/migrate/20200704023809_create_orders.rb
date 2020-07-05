class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.string :name
      t.string :postcode
      t.string :address
      t.integer :postage
      t.integer :total_products_cost
      t.boolean :payment_method, default: true
      t.integer :order_status

      t.timestamps
    end
  end
end

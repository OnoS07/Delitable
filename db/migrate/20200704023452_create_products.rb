class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.integer :genre_id
      t.string :name
      t.integer :price
      t.text :introduction
      t.string :product_image_id
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end

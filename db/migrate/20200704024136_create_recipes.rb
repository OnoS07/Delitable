class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.integer :customer_id
      t.string :title
      t.text :introduction
      t.string :recipe_image_id
      t.string :amount

      t.timestamps
    end
  end
end

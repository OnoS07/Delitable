class CreateIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients do |t|
      t.integer :recipe_id
      t.string :content
      t.string :amount

      t.timestamps
    end
  end
end

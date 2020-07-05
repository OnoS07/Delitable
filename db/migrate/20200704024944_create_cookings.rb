class CreateCookings < ActiveRecord::Migration[5.2]
  def change
    create_table :cookings do |t|
      t.integer :recipe_id
      t.string :cooking_image_id
      t.string :content
      t.string :point

      t.timestamps
    end
  end
end

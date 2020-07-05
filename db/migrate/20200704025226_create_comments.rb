class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :customer_id
      t.integer :recipe_id
      t.string :content

      t.timestamps
    end
  end
end

class RemoveCookingImageIdFromCooking < ActiveRecord::Migration[5.2]
  def change
    remove_column :cookings, :cooking_image_id, :string
  end
end

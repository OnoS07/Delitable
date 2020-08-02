class AddImpressionsCountToRecipe < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :impressions_count, :integer, default: 0
  end
end

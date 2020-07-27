class AddContentToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :content, :string
  end
end

class ChangeDataContentToReview < ActiveRecord::Migration[5.2]
  def change
    change_column :reviews, :content, :text
  end
end

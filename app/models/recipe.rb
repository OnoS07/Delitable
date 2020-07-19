class Recipe < ApplicationRecord
  belongs_to :customer
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :cookings, dependent: :destroy
  has_many :ingredients, dependent: :destroy

  attachment :recipe_image

  enum recipe_status: { レシピ: 0, 材料: 1, 作り方: 2, 完成: 3 }

  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end
end

class Recipe < ApplicationRecord
  belongs_to :customer
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :cookings, dependent: :destroy
  has_many :ingredients, dependent: :destroy
end

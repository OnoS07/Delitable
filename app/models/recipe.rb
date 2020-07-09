class Recipe < ApplicationRecord
  belongs_to :customer
  has_many :favorites, dependent: :desteroy
  has_many :comments, dependent: :desteroy

  has_many :cookings, dependent: :desteroy
  has_many :ingredients, dependent: :desteroy
end

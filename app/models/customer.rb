class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :recipes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :shipping, dependent: :destroy
  has_many :orders
  has_many :cart_items, dependent: :destroy

  attachment :profile_image

  enum is_active: { 退会済: false, 有効: true }
  acts_as_paranoid
end

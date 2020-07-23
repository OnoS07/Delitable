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

  validates :account_name, presence:true ,length:{maximum: 10}
  # validates :tel, presence:true ,format: { with: /\A\d{10,11}\z/ }
  # validates :postcode, presence: true, format: { with: /\A\d{7}\z/ }
  # validates :address, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
end

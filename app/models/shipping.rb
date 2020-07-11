class Shipping < ApplicationRecord
  belongs_to :customer
  def finally_address
    "〒#{postcode} #{address} #{name}"
  end

  validates :postcode, presence: true, format: { with: /\A\d{7}\z/ }
  validates :address, presence: true
  validates :name, presence: true
end

class Shipping < ApplicationRecord
  belongs_to :customer
  def finally_address
    "〒#{postcode} #{address} #{name}"
  end

  validates :postcode, presence: true
  validates :postcode, format: { with: /\A\d{7}\z/ }, if: proc{ |s| s.postcode.present?}
  validates :address, presence: true
  validates :name, presence: true
end

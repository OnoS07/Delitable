class Shipping < ApplicationRecord
	belongs_to :customer
  def finally_address
    "〒#{self.postcode} #{self.address} #{self.name}"
  end
end

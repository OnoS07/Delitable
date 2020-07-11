class Favorite < ApplicationRecord
  belongs_to :recipe
  belongs_to :customer
end

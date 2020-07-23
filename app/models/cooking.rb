class Cooking < ApplicationRecord
  belongs_to :recipe

  validates :content, presence:true ,length:{maximum: 100}
end

class Cooking < ApplicationRecord
  belongs_to :recipe
  acts_as_list scope: :recipe

  validates :content, presence: true, length: { maximum: 200 }
end

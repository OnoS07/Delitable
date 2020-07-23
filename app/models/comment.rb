class Comment < ApplicationRecord
  belongs_to :recipe
  belongs_to :customer

  validates :content, presence:true ,length:{maximum: 200}
end

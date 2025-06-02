class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_one :notifiable, polymorphic: true, dependent: :destroy

  validates :user_id, uniqueness: { scope: :post_id, message: "has already liked this post" }
end

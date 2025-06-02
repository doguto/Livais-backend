class Repost < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_one :notifiable, as: :notifiable, dependent: :destroy
end

class Repost < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_one :notifiable, polymorphic: true, dependent: :destroy
end

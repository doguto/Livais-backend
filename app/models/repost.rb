class Repost < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: true
  has_one :notifiable, as: :notifiable, dependent: :destroy
end

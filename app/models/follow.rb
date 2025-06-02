class Follow < ApplicationRecord
  belongs_to :follower, class_name: "User", inverse_of: :followee_relationships
  belongs_to :followed, class_name: "User", inverse_of: :follower_relationships
  has_one :notifiable, as: :notifiable, dependent: :destroy
end

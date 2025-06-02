class Post < ApplicationRecord
  belongs_to :user
  validates :content, presence: true

  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  has_many :reposts, dependent: :destroy
  has_many :reposting_user, through: :reposts, source: :user

  belongs_to :parent_post, class_name: "Post", foreign_key: "reply_to_id", optional: true, inverse_of: :replies
  has_many :replies, class_name: "Post", foreign_key: "reply_to_id", dependent: :destroy, inverse_of: :parent_post

  has_one :notifiable, polymorphic: true, dependent: :destroy
end

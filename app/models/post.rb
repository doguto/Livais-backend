class Post < ApplicationRecord
  belongs_to :user
  validates :content, presence: true

  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
  has_many :current_user_likes, -> { where(user: Current.current_user) }, class_name: "Like"

  has_many :reposts, dependent: :destroy
  has_many :reposting_user, through: :reposts, source: :user
  has_many :current_user_reposts, -> { where(user: Current.current_user) }, class_name: "Repost"

  belongs_to :parent_post, class_name: "Post", foreign_key: "reply_to_id", optional: true, inverse_of: :replies, counter_cache: :replies_count
  has_many :replies, class_name: "Post", foreign_key: "reply_to_id", dependent: :destroy, inverse_of: :parent_post
end

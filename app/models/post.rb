class Post < ApplicationRecord
  belongs_to :user
  validates :content, presence: true

  has_many :likes, inverse_of: :post, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
  has_many :current_user_likes, -> { where(user: Current.current_user) }, class_name: "Like", inverse_of: :post, dependent: :destroy

  has_many :reposts, inverse_of: :post, dependent: :destroy
  has_many :reposting_user, through: :reposts, source: :user
  has_many :current_user_reposts, -> { where(user: Current.current_user) }, class_name: "Repost", inverse_of: :post, dependent: :destroy

  belongs_to :parent_post, class_name: "Post", foreign_key: "reply_to_id", optional: true, inverse_of: :replies, counter_cache: :replies_count
  has_many :replies, class_name: "Post", foreign_key: "reply_to_id", dependent: :destroy, inverse_of: :parent_post

  belongs_to :quoted_post, class_name: "Post", optional: true, counter_cache: :quotes_count

  has_many :quoting_posts, class_name: "Post", foreign_key: "quoted_post_id", dependent: :nullify, inverse_of: :quoted_post
end

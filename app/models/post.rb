class Post < ApplicationRecord
  belongs_to :user
  validates :content, presence: true

  has_many :likes, inverse_of: :post, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
  has_many :current_user_likes, -> { where(user: Current.current_user) }, class_name: "Like", inverse_of: :post, dependent: :destroy

  has_many :reposts, inverse_of: :post, dependent: :destroy
  has_many :reposting_user, through: :reposts, source: :user
  has_many :current_user_reposts, -> { where(user: Current.current_user) }, class_name: "Repost", inverse_of: :post, dependent: :destroy

  has_one :parent_reply, class_name: "Reply", inverse_of: :child_post, dependent: :destroy
  has_one :parent_post, class_name: "Post", through: :parent_reply
  has_many :child_replies, class_name: "Reply", inverse_of: :parent_post, dependent: :destroy, counter_cache: :replies_count
  has_many :child_posts, class_name: "Post", through: :child_replies, source: :child_post

  has_one :quote, class_name: "Quote", inverse_of: :quoting_post, dependent: :nullify
  has_one :quoted_post, class_name: "Post", through: :quote
end

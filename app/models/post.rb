# == Schema Information
#
# Table name: posts
#
#  id             :integer          not null, primary key
#  content        :string(280)
#  likes_count    :integer          default(0), not null
#  quotes_count   :integer          default(0), not null
#  replies_count  :integer          default(0), not null
#  reposts_count  :integer          default(0), not null
#  status         :string           default("published")
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  quoted_post_id :bigint
#  reply_to_id    :bigint
#  user_id        :bigint
#
# Indexes
#
#  index_posts_on_quoted_post_id  (quoted_post_id)
#  index_posts_on_reply_to_id     (reply_to_id)
#  index_posts_on_user_id         (user_id)
#
# Foreign Keys
#
#  quoted_post_id  (quoted_post_id => posts.id)
#  reply_to_id     (reply_to_id => posts.id)
#  user_id         (user_id => users.id)
#
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

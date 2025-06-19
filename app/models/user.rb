# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  name            :string
#  email           :string           not null
#  image           :string
#  password_digest :string
#  provider        :string
#  uid             :string
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_one :profile, dependent: :destroy

  has_many :follower_relationships,
           foreign_key: :followed_id,
           class_name: "Follow",
           inverse_of: :followed,
           dependent: :destroy

  has_many :followee_relationships,
           foreign_key: :follower_id,
           class_name: "Follow",
           inverse_of: :follower,
           dependent: :destroy

  has_many :followers, through: :follower_relationships, source: :follower

  has_many :following, through: :followee_relationships, source: :followed

  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  has_many :reposts, dependent: :destroy
  has_many :reposted_posts, through: :reposts, source: :post

  has_secure_password validations: false

  validates :password, presence: true, if: :password_required?

  def following_ids_as_set
    following.pluck(:id).to_set
  end

  private

  def password_required?
    provider.blank? || provider == "email"
  end
end

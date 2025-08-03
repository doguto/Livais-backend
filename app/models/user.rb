# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  image           :string
#  name            :string
#  password_digest :string
#  provider        :string
#  uid             :string
#  created_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email             (email) UNIQUE
#  index_users_on_uid_and_provider  (uid,provider) UNIQUE
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

  has_one :notice_setting, dependent: :destroy

  has_secure_password validations: false

  validates :password, presence: true, if: :password_required?

  after_create :create_notice_setting

  def following_ids_as_set
    following.pluck(:id).to_set
  end

  def create_notice_setting
    NoticeSetting.create(user_id: id)
  end

  def self.from_omniauth(auth)
    where(uid: auth.uid, provider: auth.provider).first_or_create do |user|
      user.email = auth.info.email
      user.name = auth.info.name
      user.image = auth.info.image
      user.provider = auth.provider
      user.uid = auth.uid
    end
  end

  private

  def password_required?
    provider.blank? || provider == "email"
  end
end

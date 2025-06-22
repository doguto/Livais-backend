# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
#  bio        :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#

class Profile < ApplicationRecord
  belongs_to :user

  validates :bio, presence: true
end

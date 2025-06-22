# == Schema Information
#
# Table name: notices
#
#  id              :integer          not null, primary key
#  is_hide         :boolean          default(FALSE), not null
#  notifiable_type :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  notifiable_id   :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_notices_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Notice < ApplicationRecord
  belongs_to :user
  belongs_to :notifiable, polymorphic: true
end

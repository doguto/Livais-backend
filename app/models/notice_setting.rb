# == Schema Information
#
# Table name: notice_settings
#
#  id            :integer          not null, primary key
#  follow_enable :boolean          default(TRUE), not null
#  like_enable   :boolean          default(TRUE), not null
#  quote_enable  :boolean          default(TRUE), not null
#  reply_enable  :boolean          default(TRUE), not null
#  repost_enable :boolean          default(TRUE), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer          not null
#
# Indexes
#
#  index_notice_settings_on_user_id  (user_id)
#
class NoticeSetting < ApplicationRecord
  belongs_to :user
end

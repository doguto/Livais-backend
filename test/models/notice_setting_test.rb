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
#  user_id       :bigint           not null
#
# Indexes
#
#  index_notice_settings_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
require "test_helper"

class NoticeSettingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

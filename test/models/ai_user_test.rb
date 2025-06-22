# == Schema Information
#
# Table name: ai_users
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  ai_model_id :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_ai_users_on_ai_model_id  (ai_model_id)
#  index_ai_users_on_user_id      (user_id)
#
# Foreign Keys
#
#  ai_model_id  (ai_model_id => ai_models.id)
#  user_id      (user_id => users.id)
#

require "test_helper"

class AiUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

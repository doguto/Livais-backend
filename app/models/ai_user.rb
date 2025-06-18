# == Schema Information
#
# Table name: ai_users
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer          not null
#  ai_model_id :integer          not null
#
# Indexes
#
#  index_ai_users_on_ai_model_id  (ai_model_id)
#  index_ai_users_on_user_id      (user_id)
#

class AiUser < ApplicationRecord
  belongs_to :user
  belongs_to :ai_model
end

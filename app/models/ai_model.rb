# == Schema Information
#
# Table name: ai_models
#
#  id         :integer          not null, primary key
#  model      :string
#  string     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class AiModel < ApplicationRecord
end

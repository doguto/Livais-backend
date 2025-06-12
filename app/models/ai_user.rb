class AiUser < ApplicationRecord
  belongs_to :user
  belongs_to :ai_model
end

# == Schema Information
#
# Table name: reposts
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  post_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_reposts_on_user_id_and_post_id  (user_id,post_id) UNIQUE
#

class Repost < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: true
end

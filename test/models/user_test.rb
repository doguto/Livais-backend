# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  name            :string
#  email           :string           not null
#  image           :string
#  password_digest :string
#  provider        :string
#  uid             :string
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

module Page::ProfilePage
  class FollowsGetDomain < ApplicationDomain
    def initialize(user_id:)
      super
      @user_id = user_id
    end

    def execute
      user = User.find(@user_id)
      user.followee_relationships.map(&:followed)
    end
  end
end

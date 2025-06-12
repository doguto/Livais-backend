module Page::ProfilePage
  class ShowUserWithProfileDomain < ApplicationDomain
    def initialize(user_id:)
      super()
      @user_id = user_id
    end

    def execute
      User.includes(:profile).find(@user_id)
    end
  end
end

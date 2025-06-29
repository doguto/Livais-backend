module Page::ProfilePage
  class ShowUserWithProfileDomain < ApplicationDomain
    def initialize
      super
    end

    def execute(user_id: Current.current_user)
      user = User.includes(:profile, :followers, :following).find(user_id)
      ProfileDto.new(user)
    end
  end
end

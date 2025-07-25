module Page::ProfilePage
  class ShowUserWithProfileDomain < ApplicationDomain
    def execute(user_id: Current.current_user&.id)
      user = User.includes(:profile, :followers, :following).find(user_id)
      ProfileDto.new(user)
    end
  end
end

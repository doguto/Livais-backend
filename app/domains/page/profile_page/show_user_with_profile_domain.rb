module Page::ProfilePage
  class ShowUserWithProfileDomain < ApplicationDomain
    def initialize(user_id:)
      super()
      @user_id = user_id
    end

    def execute
      user = User.includes(:profile, :followers, :following).find(@user_id)
      ProfileDto.new(user).to_h.deep_transform_keys { |key| key.to_s.camelize(:lower) }
    end
  end
end

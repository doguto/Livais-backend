module Page::AuthPage
  class AuthenticateUserDomain < ApplicationDomain
    def execute(token)
      decoded_token = JsonWebToken.decode(token)
      user = User.find_by(id: decoded_token[:user_id])
      raise "Unauthorized" if user.nil?

      Current.current_user = user unless user.nil?

      user
    end
  end
end

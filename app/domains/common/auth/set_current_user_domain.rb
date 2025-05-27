module Common::Auth
  class SetCurrentUserDomain < ApplicationDomain
    def execute(token:)
      return unless token

      decoded = JsonWebToken.decode(token)
      current_user = User.find_by(id: decoded[:user_id]) if decoded

      Current.current_user = current_user
    rescue JWT::DecodeError => e
      Rails.logger.warn("JWT::DecodeError occurred: #{e.message}")
      nil
    end
  end
end

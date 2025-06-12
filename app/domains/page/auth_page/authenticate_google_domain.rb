require "google-id-token"

module Page::AuthPage
  class AuthenticateGoogleDomain < ApplicationDomain
    def initialize(credential:)
      super()
      @credential = credential
    end

    def execute
      validator = GoogleIDToken::Validator.new
      payload = validator.check(@credential, ENV.fetch("GOOGLE_CLIENT_ID", nil))

      user = User.find_or_create_by(email: payload["email"], provider: "google", uid: payload["sub"]) do |u|
        u.name = payload["name"]
        u.image = payload["picture"]
      end

      token = JsonWebToken.encode(user_id: user.id)
      [token, user]
    rescue GoogleIDToken::ValidationError
      raise "Invalid Google token"
    end
  end
end

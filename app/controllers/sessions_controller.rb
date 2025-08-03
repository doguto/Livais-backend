class SessionsController < ApplicationController
  def omniauth
    auth = request.env["omniauth.auth"]
    user = User.from_omniauth(auth)

    if user.persisted?
      token = JsonWebToken.encode(user_id: user.id)

      # TODO: クエリパラメータではなくcookieにトークンを保存するようにする (https://github.com/doguto/Livais-backend/issues/198)
      redirect_to "#{ENV.fetch('FRONTEND_URL', 'http://localhost:3001')}/auth/callback?token=#{token}",
                  allow_other_host: true
    else
      redirect_to "#{ENV.fetch('FRONTEND_URL', 'http://localhost:3001')}/signin?error=oauth_failed",
                  allow_other_host: true
    end
  end

  def destroy
    head :no_content
  end
end

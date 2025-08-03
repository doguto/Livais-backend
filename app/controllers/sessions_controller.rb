class SessionsController < ApplicationController
  def omniauth
    auth = request.env['omniauth.auth']
    user = User.from_omniauth(auth)
    
    if user.persisted?
      # JWTトークン生成
      token = JsonWebToken.encode(user_id: user.id)
      
      # フロントエンドにトークンをクエリパラメータで渡す
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
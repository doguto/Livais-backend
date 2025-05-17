class JwtTokenService
  def self.encode(user)
    JsonWebToken.encode(user_id: user.id)
  end
end

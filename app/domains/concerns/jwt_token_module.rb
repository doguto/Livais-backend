module JwtTokenModule
  def encode(user)
    JsonWebToken.encode(user_id: user.id)
  end
end

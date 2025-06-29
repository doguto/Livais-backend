class ProfileDto
  def initialize(user)
    @user = user
  end

  def get
    {
      user_id: @user.id,
      user: {
        name: @user.name,
        image: @user.image,
        cover_image: @user.profile&.cover_image,
        bio: @user.profile&.bio,
        join_date: @user.created_at.strftime("%Y-%m-%d"),
        follow_count: @user.following.size,
        follower_count: @user.followers.size
      }.camelize
    }.camelize
  end
end

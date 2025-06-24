class ProfileDto
  def initialize(user)
    @user = user
  end

  def get
    {
      user_id: @user.id,
      user: {
        name: @user.name,
        username: @user.username,
        image: @user.image,
        cover_image: @user.profile&.cover_image,
        bio: @user.profile&.bio,
        join_date: @user.created_at.strftime("%Y-%m-%d"),
        follow_count: @user.following.count,
        follower_count: @user.followers.count
      }.camelize
    }.camelize
  end
end

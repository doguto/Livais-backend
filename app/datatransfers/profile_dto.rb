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
        self_introduction: @user.profile&.self_introduction,
        join_date: @user.created_at.strftime("%Y-%m-%d"),
        follow_count: @user.follow_count,
        follower_count: @user.follower_count
      }.camelize
    }.camelize
  end
end

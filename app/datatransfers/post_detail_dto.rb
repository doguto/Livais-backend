class PostDetailDto
  def initialize(post:, current_user: nil, liked_by_current_user: false, is_following_user: true)
    @post = post
    @current_user = current_user
    @is_following_user = is_following_user
    @liked_by_current_user = liked_by_current_user
  end

  def get
    {
      "id" => @post.id,
      "content" => @post.content,
      "created_at" => @post.created_at,
      "updated_at" => @post.updated_at,
      "user_id" => @post.user_id,
      "reply_to_id" => @post.reply_to_id,
      "user" => {
        "id" => @post.user.id,
        "name" => @post.user.name,
        "image" => @post.user.image,
        "is_following" => @is_following_user
      }.camelize,
      "replies_count" => @post.replies.count,
      "likes_count" => @post.likes.count,
      "reposts_count" => @post.reposts.count,
      "liked" => @liked_by_current_user,
      "replies" => @post.replies.order(created_at: :asc).map { |post| PostDetailDto.new(post, @current_user).get }
    }.camelize
  end

  private

  def following_user?
    return false unless @current_user

    @current_user.following.exists?(id: @post.user.id)
  end
end

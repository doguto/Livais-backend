class PostDetailDto
  def initialize(post:, is_following_user: true, current_user_id: nil)
    @post = post
    @current_user = current_user_id
    @is_following_user = is_following_user
  end

  def as_json
    {
      id: @post.id,
      content: @post.content,
      created_at: @post.created_at,
      updated_at: @post.updated_at,
      user_id: @post.user_id,
      reply_to_id: @post.reply_to_id,
      user: {
        id: @post.user.id,
        name: @post.user.name,
        image: @post.user.image,
        is_following: @is_following_user
      },
      replies_count: @post.replies.count,
      likes_count: @post.likes.count,
      reposts_count: @post.reposts.count,
      replies: @post.replies.order(created_at: :asc).map { |post| PostDetailDto.new(post, @current_user).as_json }
    }
  end
end

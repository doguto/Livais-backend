class PostDto
  def initialize(post, is_following_user: false, is_liked_by_current_user: false)
    @post = post
    @is_following_user = is_following_user
    @is_liked_by_current_user = is_liked_by_current_user
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
      "is_liked" => @is_liked_by_current_user
    }.camelize
  end
end

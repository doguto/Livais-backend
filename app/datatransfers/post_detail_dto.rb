class PostDetailDto
  def initialize(post:, is_liked: false, is_following_user: true, is_reposted: false, replies: [])
    @post = post
    @is_following_user = is_following_user
    @is_liked = is_liked
    @is_reposted = is_reposted
    @replies = replies
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
      "is_liked" => @is_liked,
      "is_reposted" => @is_reposted,
      "replies" => @replies
    }.camelize
  end
end

class PostDetailDto
  def initialize(post:, is_liked: false, is_following_user: true, is_reposted: false, replies: [])
    @post = post
    @is_following_user = is_following_user
    @is_liked = is_liked
    @is_reposted = is_reposted
    @replies = replies
    @quoted_post = if post.quoted_post.present?
                     {
                       "id" => post.quoted_post.id,
                       "content" => post.quoted_post.content,
                       "created_at" => post.quoted_post.created_at,
                       "user" => {
                         "id" => post.quoted_post.user.id,
                         "name" => post.quoted_post.user.name,
                         "image" => post.quoted_post.user.image
                       }
                     }.camelize
                   end
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
      "replies" => @replies,
      "quoted_post" => @quoted_post
    }.camelize
  end
end

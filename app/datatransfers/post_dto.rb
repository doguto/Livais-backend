class PostDto
  def initialize(post, is_following_user: false, is_liked: true, is_reposted: false)
    @post = post
    @is_following_user = is_following_user
    @is_liked = is_liked
    @is_reposted = is_reposted
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
      "reply_to_id" => @post.parent_post&.id,
      "user" => {
        "id" => @post.user.id,
        "name" => @post.user.name,
        "image" => @post.user.image,
        "is_following" => @is_following_user
      }.camelize,
      "replies_count" => @post.replies_count,
      "likes_count" => @post.likes_count,
      "reposts_count" => @post.reposts_count,
      "is_liked" => @is_liked,
      "is_reposted" => @is_reposted,
      "quoted_post" => @quoted_post
    }.camelize
  end

  def self.from_collection(posts, following_ids: Set.new)
    posts.map do |post|
      is_following_user = following_ids.include?(post.user_id)
      is_liked = post.current_user_likes.any?
      is_reposted = post.current_user_reposts.any?

      new(post, is_following_user: is_following_user, is_liked: is_liked, is_reposted: is_reposted)
    end
  end
end

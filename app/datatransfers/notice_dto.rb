class NoticeDto
  def initialize(notice, user: nil, post: nil)
    @notice = notice
    @user = user
    @post = post
  end

  def get
    {
      id: @notice.id,
      user_id: @user&.id,
      user_name: @user&.name,
      post_id: @post&.id,
      post_content: @post&.content,
      notifiable_type: @notice.notifiable_type,
      notifiable_id: @notice.notifiable_id,
      created_at: @notice.created_at,
      updated_at: @notice.updated_at
    }.camelize
  end
end

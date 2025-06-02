class NoticeDto
  def initialize(notice, user_id: nil, post_id: nil)
    @notice = notice
    @user_id = user_id
    @post_id = post_id
  end

  def get
    {
      id: @notice.id,
      user_id: @user_id,
      post_id: @post_id,
      notifiable_type: @notice.notifiable_type,
      notifiable_id: @notice.notifiable_id,
      created_at: @notice.created_at,
      updated_at: @notice.updated_at,
      notifiable: @notice.notifiable.as_json(only: [:id, :content, :created_at]).camelize
    }.camelize
  end
end

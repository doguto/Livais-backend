class NoticeDto
  def initialize(notice, user: nil, post: nil)
    @notice = notice
    @user = user # Noticeになるようなアクションをしたユーザー
    @post = post
  end

  def get
    {
      id: @notice.id,
      user: {
        id: @user.id,
        name: @user.name,
        image: @user.image,
        is_following: true
      }.camelize,
      post: {
        id: @post&.id,
        content: @post&.content
      }.camelize,
      notifiable_type: @notice.notifiable_type,
      notifiable_id: @notice.notifiable_id,
      created_at: @notice.created_at,
      updated_at: @notice.updated_at
    }.camelize
  end
end

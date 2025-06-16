module Page::NoticePage
  class ShowNoticeDomain < ApplicationDomain
    POST_NOTICE_TYPE = ["Repost", "Like", "Post"].freeze
    FOLLOW_NOTICE_TYPE = ["Follow"].freeze

    def execute
      notices = Notice.where(user_id: Current.current_user&.id, is_hide: false).includes(:notifiable).order(created_at: :desc)
      dtos = []
      notices.map do |notice|
        if FOLLOW_NOTICE_TYPE.include?(notice.notifiable_type)
          from_user = User.find_by(id: notice.notifiable.follower_id)
          dtos << NoticeDto.new(notice, user: from_user)
        elsif POST_NOTICE_TYPE.include?(notice.notifiable_type)
          from_user = User.find_by(id: notice.notifiable.user_id)
          post = Post.find_by(id: notice.notifiable.post_id)
          dtos << NoticeDto.new(notice, user: from_user, post: post)
        end
      end
      dtos
    end
  end
end

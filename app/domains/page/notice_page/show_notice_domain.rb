module Page::NoticePage
  class ShowNoticeDomain < ApplicationDomain
    POST_NOTICE_TYPE = ["Repost", "Like"].freeze
    FOLLOW_NOTICE_TYPE = ["Follow"].freeze
    REPLY_TYPE = ["Reply"].freeze
    QUOTE_TYPE = ["Quote"].freeze

    def execute
      notices = Notice.where(user_id: Current.current_user&.id, is_hide: false).includes(:notifiable).order(created_at: :desc)
      notices.map do |notice|
        if FOLLOW_NOTICE_TYPE.include?(notice.notifiable_type)
          NoticeDto.new(notice, user: notice.notifiable.follower)
        elsif POST_NOTICE_TYPE.include?(notice.notifiable_type)
          NoticeDto.new(notice, user: notice.notifiable.user, post: notice.notifiable.post)
        elsif REPLY_TYPE.include?(notice.notifiable_type)
          NoticeDto.new(notice, user: notice.notifiable.child_post.user, post: notice.notifiable.child_post)
        elsif QUOTE_TYPE.include?(notice.notifiable_type)
          NoticeDto.new(notice, user: notice.notifiable.quoting_post.user, post: notice.notifiable.quoting_post)
        else
          NoticeDto.new(notice)
        end
      end
    end
  end
end

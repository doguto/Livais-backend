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
          NoticeDto.new(notice, user_id: notice.notifiable.follower_id)
        elsif POST_NOTICE_TYPE.include?(notice.notifiable_type)
          NoticeDto.new(notice, user_id: notice.notifiable.user_id, post_id: notice.notifiable.post_id)
        elsif REPLY_TYPE.include?(notice.notifiable_type)
          NoticeDto.new(notice, user_id: notice.notifiable.child_post.user_id, post_id: notice.notifiable.child_post_id)
        elsif QUOTE_TYPE.include?(notice.notifiable_type)
          NoticeDto.new(notice, user_id: notice.notifiable.quoting_post.user_id, post_id: notice.notifiable.quoting_post_id)
        else
          NoticeDto.new(notice)
        end
      end
    end
  end
end

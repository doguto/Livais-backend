module Page::NoticePage
  class ShowNoticeDomain < ApplicationDomain
    POST_NOTICE_TYPE = ["Repost", "Like"].freeze
    FOLLOW_NOTICE_TYPE = ["Follow"].freeze
    REPLY_TYPE = ["Reply"].freeze
    QUOTE_TYPE = ["Quote"].freeze

    def execute
      user = Current.current_user
      notice_setting = user.notice_setting

      notice_type = []
      notice_type << "Like" if notice_setting.like_enable
      notice_type << "Repost" if notice_setting.repost_enable
      notice_type << "Quote" if notice_setting.quote_enable
      notice_type << "Reply" if notice_setting.reply_enable
      notice_type << "Follow" if notice_setting.follow_enable

      notices = Notice.where(user_id: user&.id, is_hide: false, notifiable_type: notice_type).includes(:notifiable).order(created_at: :desc)

      notices.map do |notice|
        if FOLLOW_NOTICE_TYPE.include?(notice.notifiable_type)
          next if notice.notifiable.followed_id == user.id

          dtos << NoticeDto.new(notice, user: notice.notifiable.follower)
        elsif POST_NOTICE_TYPE.include?(notice.notifiable_type)
          next if notice.notifiable.user_id == user.id

          dtos << NoticeDto.new(notice, user: notice.notifiable.user, post: notice.notifiable.post)
        elsif REPLY_TYPE.include?(notice.notifiable_type)
          next if notice.notifiable.child_post.user_id == user.id

          dtos << NoticeDto.new(notice, user: notice.notifiable.child_post.user, post: notice.notifiable.child_post)
        elsif QUOTE_TYPE.include?(notice.notifiable_type)
          next if notice.notifiable.quoting_post.user_id == user.id

          dtos << NoticeDto.new(notice, user: notice.notifiable.quoting_post.user, post: notice.notifiable.quoting_post)
        else
          dtos << NoticeDto.new(notice)
        end
      end
    rescue StandardError => e
      Rails.logger.debug e.message
    end
  end
end

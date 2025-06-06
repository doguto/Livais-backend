module Page::NoticePage
  class ShowNoticeDomain < ApplicationDomain
    def initialize
      super
      @contain_post_type = ["Repost", "Like", "Post"]
    end

    def execute
      @logger_stdout.info "Executing ShowNoticeDomain"

      notices = Notice.where(user_id: Current.user&.id).includes(:notifiable).order(created_at: :desc)
      dtos = []
      notices.map do |notice|
        from_user = User.find_by(id: notice.notifiable.user_id)
        if notice.notifiable_type == "Follow"
          dtos << NoticeDto.new(notice, user: from_user)
        elsif @contain_post_type.include?(notice.notifiable_type)
          post = Post.find_by(id: notice.notifiable.id)
          dtos << NoticeDto.new(notice, user: from_user, post: post)
        end
      end
      dtos
    end
  end
end
